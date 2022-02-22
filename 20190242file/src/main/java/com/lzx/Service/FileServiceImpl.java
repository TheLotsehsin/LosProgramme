package com.lzx.Service;


import com.lzx.Dao.FileMapper;
import com.lzx.Pojo.comm;
import com.lzx.Pojo.fileMessage;
import com.lzx.Pojo.filetype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileMapper fileMapper;

    public  int insertType(String tname){return fileMapper.insertType(tname);}

    public  int insertFile(fileMessage fileMessage){
        return fileMapper.insertFile(fileMessage);
    }

    public String getAllType(String tname){return fileMapper.getAllType(tname);}

    public List<fileMessage> selFile(String tname){return fileMapper.selFile(tname);}

    public List<filetype> selAllFileType(){return fileMapper.selAllFileType();}

    public fileMessage selFileByFid(String fid){return fileMapper.selFileByFid(fid);}

    public int updateFileMessage(int fnum){return fileMapper.updateFileMessage(fnum);}

    public int insertComm(comm comm){return fileMapper.insertComm(comm);}

    public List<comm> selAllComm(int uid){return fileMapper.selAllComm(uid);}
}

