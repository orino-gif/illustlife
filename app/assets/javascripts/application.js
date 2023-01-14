// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

src="https://code.jquery.com/jquery-3.2.1.min.js"
src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"

//衝突を避ける
// jQuery.noConflict();

console.log("jQuery稼働OK");

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
$(function () {
  $('.dbl').mouseover(function() {
      // ここに処理を記述する
      $(this).css('transform','scale(2)');
  
  })
  $('.dbl').mouseout(function() {
      // ここに処理を記述する
      $(this).css('transform','scale(1)');
  })
});