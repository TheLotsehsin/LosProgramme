package com.lzx.Service;

import com.lzx.Pojo.comm;
import com.lzx.Pojo.fileMessage;
import com.lzx.Pojo.filetype;

import java.util.List;

public interface FileService {

    int insertType(String tname);

    int insertFile(fileMessage fileMessage);

    String getAllType(String tname);

    List<fileMessage> selFile(String tname);

    fileMessage selFileByFid(String fid);

    List<comm> selAllComm(int uid);

    List<filetype> selAllFileType();

    int updateFileMessage(int fnum);

    int insertComm(comm comm);
}
