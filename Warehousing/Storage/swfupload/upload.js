    function fileQueueError(file, errorCode, message) {
        try {

            var v = $("#mes").html();
            var str = "触发fileQueueError事件，参数file：" + file + "，参数errorCode：" + errorCode + "，参数message：" + message;
            $("#mes").html(v + str + "<br />");

        } catch (ex) {
            this.debug(ex);
        }

    }

    function fileDialogComplete(numFilesSelected, numFilesQueued) {
        try {
            if (numFilesQueued > 0) {

                /* var v = $("#mes").html();
                var str = "触发fileDialogComplete事件，参数numFilesSelected：" + numFilesSelected + "，参数numFilesQueued：" + numFilesQueued;
                $("#mes").html(v + str + "<br />");*/

                this.startUpload();
            }
        } catch (ex) {
            this.debug(ex);
        }
    }

    function uploadProgress(file, bytesLoaded) {

        try {
           // var percent = Math.ceil((bytesLoaded / file.size) * 100); // 计算百分比
           // $("#filename").html(file.name);
           // $("#filesize").html(file.size);
          //  $("#ysc").html(bytesLoaded);
           // $("#bfb").html(percent);

            /*  var v = $("#mes").html();
            var str = "触发uploadProgress事件，参数file：" + file + "，参数bytesLoaded：" + bytesLoaded;
            $("#mes").html(v + str + "<br />");*/
        } catch (ex) {
            this.debug(ex);
        }
    }

    function uploadSuccess(file, serverData) {
        try {
            //上传成功.输出文件名
            //alert(serverData);
            $("#pro_image_view").css("display", "block");
            $("#pro_image_view").attr("src", "pic/" + serverData);
            $("#pro_image").val("pic/" + serverData);

        } catch (ex) {
            this.debug(ex);
        }
    }

    function uploadComplete(file) {
        try {
            /*  I want the next upload to continue automatically so I'll call startUpload here */
            
            if (this.getStats().files_queued > 0) {
                this.startUpload();
            }
            return;
            var v = $("#mes").html();
            var str = "触发uploadComplete事件，参数file：" + file + "，<span style='color:red;font-weight:bold;'>文件" + file.name + "上传完成</span>";
            $("#mes").html(v + str + "<br />");

        } catch (ex) {
            this.debug(ex);
        }
    }

    function uploadError(file, errorCode, message) {

        try {
            switch (errorCode) {
                case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
                    try {

                    }
                    catch (ex1) {
                        this.debug(ex1);
                    }
                    break;
                case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
                    try {

                    }
                    catch (ex2) {
                        this.debug(ex2);
                    }
                case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:

                    break;
                default:
                    //alert(message);
                    break;
            }

            var v = $("#mes").html();
            var str = "触发uploadError事件，参数file：" + file + "，参数errorCode：" + errorCode + "，参数message：" + message;
            $("#mes").html(v + str + "<br />");

        } catch (ex3) {
            this.debug(ex3);
        }

    }