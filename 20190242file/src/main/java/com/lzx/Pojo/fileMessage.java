package com.lzx.Pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class fileMessage {
    private String fid;//文件编号
    private String fname;//文件真实名
    private Integer uid;//上传用户
    private String furl;//上传路径
    private double fsize;//文件大小
    private Integer fnum;//下载次数
    private String tname;//文件类型
    private Integer sid;//空间外键
    private String fdate;//上传日期
}
