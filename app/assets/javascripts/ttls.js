// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on("change",".preview",function(){
  //操作された要素を取得
  let elem = this
  //ファイルを読み取るオブジェクトを生成
  let fileReader = new FileReader();
  //ファイルを読み取る
  fileReader.readAsDataURL(elem.files[0]);
  //ファイル読み取りが完了したら
  fileReader.onload = (function () {
    //img要素を生成
    let lll_img = `<img class="lll_square fit_con"
    $Xlarge; src='${fileReader.result}'>`

    //画像をプレビュー
    $(elem).next(".lll_img,.edit_img").html(lll_img)
  });
})