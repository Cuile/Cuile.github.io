# 测试过程中经常卡死，必须使用单独进程启动测试
start .\hugo.exe "server --source ../ --theme=hugo-clarity --buildDrafts --minify --i18n-warnings --disableFastRender"
# sleep 2
# start microsoft-edge:http://localhost:1313
