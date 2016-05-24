<?php
/**
 * Created by PhpStorm.
 * User: sws
 * Date: 5/24/16
 * Time: 5:01 PM
 */

namespace Admin\Controller;

use Think\Controller;

class CommonController extends Controller{

    public function upload(){
        header('Content-type:text/html; charset=utf-8');
        $upload = new \Think\Upload();
        $upload->maxsize = 8388608; //8M
        $upload->ext = array('jpg', 'git', 'png', 'jepg');
        $upload->rootPath = "./Public/";
        $upload->savePath = '/image/';
        $upload->autoSub = true;
        $upload->subName  = array('date', 'Y-m');//子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        // 上传文件
        $info = $upload->upload();

        if(!$info){
            $a = array('error' => 1, 'message' => $upload->getError());
            $this->ajaxReturn($a);
        }
        else{
//            $a = C('APP_PATH');
            $a = array('error' => 0, 'url' => "/yqcms/Public/".$info['imgFile']['savepath'] . $info['imgFile']['savename']);
//            var_dump($a);
            $this->ajaxReturn($a);
        }
    }

}