# 清除上一次错误信息
Clear-Content .\err.log
# 测试过程中经常卡死，必须使用单独进程启动测试
# 将错误信息输出到err.log中
Start-Process .\hugo.exe "server --source ../ --buildDrafts --minify --disableFastRender" -RedirectStandardError .\err.log
Start-Sleep -Seconds 1
# 读取err.log内容
$err = Get-Content .\err.log
# 如果有错误信息，则打印
if ($err) {
    Out-String -InputObject $err
    # Out-String $err
}
# start microsoft-edge:http://localhost:1313