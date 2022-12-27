// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function() {
  // turbolinksを無効化したい処理
});

$(document).ready(function(){
    $('.images').slick({
        slidesToShow: 4, //表示するスライドの数
        slidesToScroll: 1, //スクロールで切り替わるスライドの数
        dots: true, //スライドの下にドットのナビゲーションを表示
        autoplay: true, //自動再生
        autoplaySpeed: 1000, //再生スピード
        
        //レスポンシブ対応させたい場合は以下も記述
        responsive: [{
          breakpoint: 768, //画面幅768pxで以下のセッティング
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2,
          }
      }]
    });
});
