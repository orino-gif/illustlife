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

$(document).ready(function() {
  $("p").text("jQuery稼働テスト(稼働中)");
});

console.log("hello");

$(document).ready(function(){
  // DOMの準備が整ってから実行するreadyは必須
  $(".slider").slick({
    speed: 800,		　 //スライドするスピード
    dots: false,　　　　　　//スライドしたのドット
    arrows: true,          //左右の矢印
    infinite: true,　　　　//スライドのループ
    pauseOnHover: false,   //ホバーしたときにスライドを一時停止しない　
  });
});
