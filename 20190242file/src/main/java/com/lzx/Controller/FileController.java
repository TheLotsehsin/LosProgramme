package com.lzx.Controller;

import com.alibaba.fastjson.JSON;
import com.lzx.Dao.FileMapper;
import com.lzx.Pojo.comm;
import com.lzx.Pojo.fileMessage;
import com.lzx.Pojo.filetype;
import com.lzx.utils.FTPFileClass;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private FileMapper fileMapper;

    @RequestMapping("/toUpload")
    public String toUpload(){
        return "upload";
    }
    @RequestMapping("/toDownload")
    public String toDownload(){
        return "download";
    }


    @RequestMapping(value = "/upload",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String  fileUpload2(@RequestParam("file") CommonsMultipartFile file, HttpSession session, HttpServletRequest request) throws IOException {
        Date date = new Date();
        fileMessage fileMessage = new fileMessage();
        String fileName = file.getOriginalFilename();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        String fid = UUID.randomUUID().toString();
        int uid = (int)session.getAttribute("uid");
        String tname = FTPFileClass.getFileType(file);


        //上传路径保存设置
        String path = request.getSession().getServletContext().getRealPath("/WebRoot/files");
        File realPath = new File(path);
        if (!realPath.exists()){
            realPath.mkdir();
        }
        System.out.println("文件id==="+fid);
        System.out.println("用户id====="+uid);
        System.out.println("文件类号===="+tname);
        System.out.println("文件上传时间===="+sdf.format(date));
        System.out.println("文件名===="+fileName);
        System.out.println("文件大小===="+file.getSize());
        //上传文件地址
        System.out.println("上传文件保存地址："+realPath);

        fileMessage.setFurl(realPath.toString());
        fileMessage.setFname(fileName);
        fileMessage.setFdate(sdf.format(date));
        fileMessage.setFid(fid);
        fileMessage.setFsize(file.getSize());
        fileMessage.setFnum(1);
        fileMessage.setUid(uid);
        fileMessage.setSid(uid);
        fileMessage.setTname(tname);

        System.out.println(fileMessage.toString());
        String tname1 = fileMapper.getAllType(tname);

        if (!tname1.equals(tname)){
            fileMapper.insertType(tname);
        }

        fileMapper.insertFile(fileMessage);

        //通过CommonsMultipartFile的方法直接写文件（注意这个时候）
        file.transferTo(new File(realPath +"/"+ file.getOriginalFilename()));
        Map<String,Object> map =new HashMap<>();
        map.put("code",0);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "/selFileByFid",produces = "application/json;charset=utf-8")
    public String selFileByFid(@RequestParam("fid") String fid){
        fileMessage fileMessage = fileMapper.selFileByFid(fid);
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("data",fileMessage);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "/selAllFiles",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllFiles(@RequestParam(value = "tname",required = false)  String tname){
        List<fileMessage> fileMessageList = fileMapper.selFile(tname);
        System.out.println("查询到的文件信息===="+fileMessageList);
        Map<String,Object> map = new HashMap<>();
        map.put("data",fileMessageList);
        map.put("code",0);
        return JSON.toJSONString(map);
    }

    @RequestMapping("/selAllType")
    @ResponseBody
    public String selAllType(){
        List<filetype> filetypes = fileMapper.selAllFileType();
        System.out.println("查询到类型==="+filetypes);
        Map<String, Object> map = new HashMap<>();
        List<String> tname = new ArrayList<>();
        for (filetype f:
                     filetypes) {
            tname.add(f.getTname());
        }
        map.put("code",0);
        map.put("tname",tname);
        return JSON.toJSONString(map);
    }

    @RequestMapping("/comm")
    public void selAllComm(@RequestParam(value = "uid",required = false) int uid,HttpSession session){
        List<comm> comms = fileMapper.selAllComm(uid);
        session.setAttribute("comms",comms);
    }

    @RequestMapping("/download")
    public String downloads(@RequestParam("fid") String fid,HttpSession session,HttpServletResponse response , HttpServletRequest request) throws Exception{
        /*文件下载步骤：

        1、设置 response 响应头

        2、读取文件 -- InputStream

        3、写出文件 -- OutputStream

        4、执行操作

        5、关闭流 （先开后关）*/

        System.out.println(fid);
        fileMessage fileMessage = fileMapper.selFileByFid(fid);
        String  path = fileMessage.getFurl();
        String  fileName = fileMessage.getFname();
        int fnum = fileMessage.getFnum();

        //写评论
        comm comm = new comm();
        Date date = new Date();
        int uid =(int) session.getAttribute("uid");
        String cid = UUID.randomUUID().toString();;
        String myComm = (String) request.getParameter("myComm");
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

        System.out.println(myComm);

        comm.setCid(cid);
        comm.setUid(uid);
        comm.setCdate(sdf.format(date));
        comm.setClr(myComm);
        comm.setFid(fid);
        fileMapper.insertComm(comm);

        //要下载的图片地址
        //1、设置response 响应头
        response.reset(); //设置页面不缓存,清空buffer
        response.setCharacterEncoding("UTF-8"); //字符编码
        response.setContentType("multipart/form-data"); //二进制传输数据
        //设置响应头
        response.setHeader("Content-Disposition",
                "attachment;fileName="+ URLEncoder.encode(fileName, "UTF-8"));

        File file = new File(path,fileName);
        //2、 读取文件--输入流
        InputStream input=new FileInputStream(file);
        //3、 写出文件--输出流
        OutputStream out = response.getOutputStream();

        byte[] buff =new byte[1024];
        int index=0;
        //4、执行 写出操作
        while((index= input.read(buff))!= -1){
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();

        fnum=fnum+1;
        fileMapper.updateFileMessage(fnum);
        return "welcome";
    }
}
