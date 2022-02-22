package com.lzx.Dao;


import com.lzx.Pojo.comm;
import com.lzx.Pojo.fileMessage;
import com.lzx.Pojo.filetype;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileMapper {

    @Select("select t_name from filetype where t_name =#{tname}")
    String getAllType(String tname);

    @Insert("insert into filetype(t_name) values(#{tname})")
    int insertType(String tname);

    @Insert("insert into filemessage(f_id,f_name,f_date,f_num,f_size,f_url,t_name,s_id,u_id) values(#{fid},#{fname},#{fdate},#{fnum},#{fsize}," +
            "#{furl},#{tname},#{sid},#{uid})")
    int insertFile(fileMessage fileMessage);

    @Select("<script>" +
            "SELECT t_name,f_id,f_name,f_date,f_num,f_size,f_url,s_id,u_id from filemessage" +
            "<where>" +
            "<if test='tname != null'>" +
            "t_name=#{tname}" +
            "</if>" +
            "</where>"+
            "</script>")
    List<fileMessage> selFile(String tname);

    @Select("SELECT * from filemessage where f_id=#{fid}")
    fileMessage selFileByFid(String fid);

    @Select("select *  from filetype")
    List<filetype> selAllFileType();

    @Select("<script>" +
            "SELECT * from comm" +
            "<where>" +
            "<if test='uid!=null'>" +
            "uid=#{uid}" +
            "</if>" +
            "</where>"+
            "</script>")
    List<comm> selAllComm(int uid);

    @Update("update table filemessage set f_num=#{fnum}")
    int updateFileMessage(int fnum);

    @Insert("insert into comm(c_id,u_id,c_lr,c_date,f_id) values(#{cid},#{uid},#{clr},#{cdate},#{fid})")
    int insertComm(comm comm);
}
