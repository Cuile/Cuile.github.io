---
title: "FFmpeg脚本"
date: 2022-02-08T10:31:15+08:00
# draft: true
tags:
- FFmpeg
- Windwos 10
---

*脚本基于Windows10系统设计*

## 查看软件版本
```batch
D:\ffmpeg\bin>ver

Microsoft Windows [版本 10.0.18362.356]

D:\ffmpeg\bin>ffmpeg.exe -version

ffmpeg version N-94600-g661a9b274b Copyright (c) 2000-2019 the FFmpeg developers
built with gcc 9.1.1 (GCC) 20190807
configuration: --enable-gpl --enable-version3 --enable-sdl2 --enable-fontconfig --enable-gnutls --enable-iconv --enable-libass --enable-libdav1d --enable-libbluray --enable-li
bfreetype --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-libopus --enable-libshine --enable-libsnappy --enable-libsoxr
 --enable-libtheora --enable-libtwolame --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxml2 --enable-libzimg --enable-lzma 
--enable-zlib --enable-gmp --enable-libvidstab --enable-libvorbis --enable-libvo-amrwbenc --enable-libmysofa --enable-libspeex --enable-libxvid --enable-libaom --enable-libmfx
 --enable-amf --enable-ffnvcodec --enable-cuvid --enable-d3d11va --enable-nvenc --enable-nvdec --enable-dxva2 --enable-avisynth --enable-libopenmpt
libavutil      56. 33.100 / 56. 33.100
libavcodec     58. 55.100 / 58. 55.100
libavformat    58. 31.101 / 58. 31.101
libavdevice    58.  9.100 / 58.  9.100
libavfilter     7. 58.100 /  7. 58.100
libswscale      5.  6.100 /  5.  6.100
libswresample   3.  6.100 /  3.  6.100
libpostproc    55.  6.100 / 55.  6.100
```

## 添加LOGO
```batch
D:\ffmpeg\bin\ffmpeg ^
                    -c:v h264_qsv ^
                    -i %1 ^
                    -i F:\\电教馆\\logo.png ^
                    -c:v h264_qsv ^
                    -b:v 1894k ^
                    -filter_complex [1:v]scale=125:125[logo];[0:v][logo]overlay=30:25 ^
                    -c:a copy ^
                    -y ^
                    %2
```

## 去掉LOGO
```batch
D:\ffmpeg\bin\ffmpeg ^
                    -c:v h264_qsv ^
                    -i %1 ^
                    -c:v h264_qsv ^
                    -b:v 1894k ^
                    -filter_complex [0:v]split[split_main][split_delogo];[split_delogo]trim=start=1:end=5,delogo=x=270:y=820:w=1420:h=50:show=0[delogoed];[split_main][delogoed]overlay=eof_action=pass ^
                    -c:a copy ^
                    -y ^
                    %2
```

## 合并操作
```batch
D:\ffmpeg\bin\ffmpeg ^
                    -c:v h264_qsv ^
                    -i %1 ^
                    -i F:\\电教馆\\logo.png ^
                    -c:v h264_qsv ^
                    -b:v 1894k ^
                    -filter_complex [1:v]scale=125:125[logo];[0:v][logo]overlay=30:25[tmp_video];[tmp_video]split[main][delogo];[delogo]trim=start=1:end=5,delogo=x=270:y=820:w=1420:h=50:show=0[delogoed];[main][delogoed]overlay=eof_action=pass ^
                    -c:a copy ^
                    -y ^
                    %2
```

## 遍历文件夹下的MP4文件，打水印、去字幕、截图验证效果
```batch
@echo off & setlocal enabledelayedexpansion

echo #################################################
echo 开始处理视频文件
echo. 
:: 指定起始文件夹
set DIR="E:\六年级\"
REM set DIR="E:\六年级\第一学期\sx6s01001\"
echo DIR=%DIR%

REM 指定运行参数
set scale="scale=90:90"
set overlay="overlay=50:15"
set trim="trim=start=2:end=6"
set delogo="delogo=x=190:y=545:w=930:h=30:show=0"

:: 参数 /R 表示需要遍历子文件夹,去掉表示不遍历子文件夹
:: %%f 是一个变量,类似于迭代器,但是这个变量只能由一个字母组成,前面带上%%
:: 括号中是通配符,可以指定后缀名,*.*表示所有文件
for /R %DIR% %%f in (*.mp4) do (
	echo f=%%f
	call :check_info "%%f" ^
	&& echo ################################################# ^
	&& echo bit_rate=!bit_rate! ^
	&& call :process_mpeg4 "%%f","%%~df%%~pf%%~nf_out%%~xf",!bit_rate!,%scale%,%overlay%,%trim%,%delogo% ^
	&& call :screenshot "%%~df%%~pf%%~nf_out%%~xf","%%~df%%~pf%%~nf_out"
)
exit /b

:check_info
	echo #################################################
	echo check_info
	for /F %%s in ('D:\ffmpeg\bin\ffprobe -hide_banner ^
											-unit -prefix -byte_binary_prefix ^
											-print_format flat ^
											-show_format -show_streams ^
											-i %1 ^| find "streams.stream.0.bit_rate"') do (set bit_rate=%%s)
	set bit_rate=%bit_rate:~27,5%
	set bit_rate=%bit_rate:.=%
goto :eof

:process_mpeg4
	echo #################################################
	echo process_mpeg4
	D:\ffmpeg\bin\ffmpeg -hide_banner ^
							-vcodec mpeg4 ^
							-i %1 -i F:\\电教馆\\logo.png ^
							-vcodec h264_qsv -b:v %3k ^
							-filter_complex [1:v]%4[logo];[0:v][logo]%5[tmp_video];[tmp_video]split[main][delogo];[delogo]%6,%7[delogoed];[main][delogoed]overlay=eof_action=pass ^
							-acodec copy ^
							-y %2
goto :eof

:process_h264_qsv
	echo #################################################
	echo process_h264_qsv
	D:\ffmpeg\bin\ffmpeg -hide_banner ^
							-vcodec h264_qsv ^
							-i %1 -i F:\\电教馆\\logo.png ^
							-vcodec h264_qsv -b:v %3k ^
							-filter_complex [1:v]%4[logo];[0:v][logo]%5[tmp_video];[tmp_video]split[main][delogo];[delogo]%6,%7[delogoed];[main][delogoed]overlay=eof_action=pass ^
							-acodec copy ^
							-y %2
goto :eof

:screenshot
	echo #################################################
	echo screenshot
	for /L %%i in (3,1,5) do (
		D:\ffmpeg\bin\ffmpeg -hide_banner ^
								-ss 00:0%%i -vcodec h264_qsv ^
								-i %1 ^
								-vframes 1 -f image2 ^
								-y %2_%%is_screenshot.jpg
	)
goto :eof
```