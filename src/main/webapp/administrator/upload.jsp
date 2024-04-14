<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href='//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css' rel='stylesheet'></link>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet"></link>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.css" rel="stylesheet"></link>
</head>
<body>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
    <font style="color: red">請修正以下錯誤:</font>
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li style="color: red">${message}</li>
        </c:forEach>
    </ul>
</c:if>

<jsp:useBean id="administratorSvc" scope="page"
             class="com.ren.administrator.service.AdministratorServiceImpl"/>

<form ACTION="administrator.do" METHOD="POST" enctype="multipart/form-data" id="imageForm">
    <!-- 隱藏的輸入字段，用於儲存管理員編號 -->
    <b>選擇管理員編號:</b>
    <select size="1" name="admNo">
        <c:forEach var="adminitratorVO" items="${administratorSvc.all}">
            <option value="${adminitratorVO.admNo}">${adminitratorVO.admNo}</option>
        </c:forEach>
        <input type="hidden" name="admNo" value="${administratorVO.admNo}">
    </select>

    <label class="btn btn-info">
        <input id="upload_img" name="uploadImg" style="display:none;" type="file" accept="image/*">
        <!-- 隱藏的輸入字段，用於儲存裁剪後的圖片數據，施工中 -->
<%--        <input type="hidden" name="croppedImage" id="croppedImage" value="">--%>
        <i class="fa fa-photo"></i> 上傳圖片
    </label>

    <!-- 裁剪按鈕 -->
    <button id="crop_img" type="button" class="btn btn-info"><i class="fa fa-scissors"></i> 裁剪圖片</button>

    <!-- 提交表單 -->
    <input type="hidden" name="action" value="upload">
    <input type="submit" value="送出">
</form>

<div id="oldImg" style="display:none;"></div>

<div id="newImgInfo"></div>
<div id="newImg"></div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.min.js"></script>

<script>
    (function ($) {
        var width_crop = 300, // 圖片裁切寬度 px 值
            height_crop = 200, // 圖片裁切高度 px 值
            type_crop = "square", // 裁切形狀: square 為方形, circle 為圓形
            width_preview = 350, // 預覽區塊寬度 px 值
            height_preview = 350, // 預覽區塊高度 px 值
            compress_ratio = 0.85, // 圖片壓縮比例 0~1
            type_img = "jpeg", // 圖檔格式 jpeg png webp
            oldImg = new Image(),
            myCrop, file, oldImgDataUrl;

        // 裁切初始參數設定
        myCrop = $("#oldImg").croppie({
            viewport: { // 裁切區塊
                width: 300,
                height: 300,
                type: "circle" // 改為圓形的裁切區塊,type_crop為方框
            },
            boundary: { // 預覽區塊
                width: width_preview,
                height: height_preview
            }
            // enableResize: true // 允許裁切窗口大小調整，因滑鼠移動控制方式還沒搞定，此段暫時拿掉
        });

        function readFile(input) {
            if (input.files && input.files[0]) {
                file = input.files[0];
            } else {
                alert("瀏覽器不支援此功能！建議使用最新版本 Chrome");
                return;
            }

            if (file.type.indexOf("image") == 0) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    oldImgDataUrl = e.target.result;
                    oldImg.src = oldImgDataUrl; // 載入 oldImg 取得圖片資訊
                    myCrop.croppie("bind", {
                        url: oldImgDataUrl
                    });
                };

                reader.readAsDataURL(file);
            } else {
                alert("您上傳的不是圖檔！");
            }
        }

        function displayCropImg(src) {
            var html = "<img src='" + src + "' />";
            $("#newImg").html(html);
        }

        $("#upload_img").on("change", function () {
            $("#oldImg").show();
            readFile(this);
        });

        oldImg.onload = function () {
            var width = this.width,
                height = this.height,
                fileSize = Math.round(file.size / 1000),
                html = "";

            html += "<p>原始圖片尺寸 " + width + "x" + height + "</p>";
            html += "<p>檔案大小約 " + fileSize + "k</p>";
            $("#oldImg").before(html);
        };

        function displayNewImgInfo(src) {
            var html = "",
                filesize = src.length * 0.75;

            html += "<p>裁切圖片尺寸 " + width_crop + "x" + height_crop + "</p>";
            html += "<p>檔案大小約 " + Math.round(filesize / 1000) + "k</p>";
            $("#newImgInfo").html(html);
        }
        
        $("#crop_img").on("click", function () {
            myCrop.croppie("result", {
                type: "canvas",
                format: type_img,
                quality: compress_ratio
            }).then(function (src) {
                displayCropImg(src);

                // 將裁剪後的圖片數據設置到隱藏的輸入字段中
                $("#croppedImage").val(src);

                displayNewImgInfo(src);
            });
        });

        // $("#crop_img").on("click", function () {
        //     myCrop.croppie("result", {
        //         type: "blob", // ??型?置? blob 而不是 canvas 以得到 Blob 格式的?片?据
        //         format: type_img, // ?置?像格式，通常是 jpeg、png 或 webp
        //         quality: compress_ratio // ?置?片?量
        //     }).then(function (blob) {
        //         // 在?段代?中，'blob' 是裁切后的?片的 Blob ?象
        //         displayCropImg(URL.createObjectURL(blob)); // 使用 URL.createObjectURL(blob) ? Blob ?象???可用的 URL
        //
        //         // ?裁切后的 Blob ?据?置到?藏的?入字段中
        //         // ?里? Blob ?据附加到表??据中
        //         const formData = new FormData();
        //         formData.append('croppedImage', blob, 'cropped-image.' + type_img);
        //         document.getElementById('imageForm').append(formData);
        //
        //         // ?示裁切后的?片信息
        //         displayNewImgInfo(blob);
        //     });
        // });

    })(jQuery);
</script>

</body>
</html>