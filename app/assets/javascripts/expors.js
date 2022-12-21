// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on("change",".preview-uploader",function(){
    //操作された要素を取得
    let elem = this
    //ファイルを読み取るオブジェクトを生成
    let fileReader = new FileReader();
    //ファイルを読み取る
    fileReader.readAsDataURL(elem.files[0]);
    //ファイル読み取りが完了したら
    fileReader.onload = (function () {
      //img要素を生成
      let imgTag = 
      `<img class="fit_con m_rect"
      $Xlarge; src='${fileReader.result}'>`
      //画像をプレビュー
      $(elem).next(".preview").html(imgTag)
    });
})

$(function () {
  $('.g_text').hide();
  $('.preview-uploader, .preview').hide();
    // ラジオボタンを選択変更したら実行
    $('input[name="expor[kind]"]').change(function () {
        var val = $(this).val();
        if (val == 'キャラデザ(文字)'){
          console.log(val);
          $('.g_text').show();
          $('.preview-uploader, .preview').hide();
        } else if (val == 'キャラデザ(ラフ)'){
          $('.g_text').hide();
          $('.preview-uploader, .preview').show();
          console.log(val);
        }else if (val == 'ラフ'){
          $('.g_text').hide();
          $('.preview-uploader, .preview').show();
          console.log(val);
        } else if (val == 'プロット'){
          $('.g_text').show();
          $('.preview-uploader, .preview').hide();
          console.log(val);
        } else if (val == 'ネーム'){
          $('.g_text').hide();
          $('.preview-uploader, .preview').show();
          console.log(val);
        }
    });
});