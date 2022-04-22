## 命令工具

#
type=$1

# 删除已经生成的目录
delete_docs() {
    echo '删除已经生成的目录 docs'
    rm -rf docs
}

book_rename() {
    echo '修改生成的书本目录名称'
    mv _book docs
}

build() {
    echo '构建书籍'
    gitbook install
    gitbook build    
}

start_serve() {
    echo '启动服务'
    rm -rf _book
    delete_docs
    gitbook serve
}

if [ $type == 'serve' ];then
    echo '启动本地服务开始.....'
    start_serve
elif [ $type == 'push' ];then
    echo '代码发布'
    delete_docs
    build
    book_rename
    git add .
    git commit -m 'update'
    git push
elif [ $type == 'help' ];then
    echo '支持命令 serve-启动本地服务 push-打包并发布到github'    
else
    echo '命令无效'
fi