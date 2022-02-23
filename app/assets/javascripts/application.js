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
src="https://js.pay.jp/"

// // DOM読み込みが完了したら実行
// document.addEventListener('DOMContentLoaded', (e) => {
//   // payjp.jsの初期化
//   Payjp.setPublicKey('pk_live_860cbe2d5bbdb3165c595a32');
  
//   // ボタンのイベントハンドリング
//   const btn = document.getElementById('token');
//   btn.addEventListener('click', (e) => {
//     e.preventDefault();
    
//     // カード情報生成
//     const card = {
//       number: document.getElementById('card_number').value,
//       cvc: document.getElementById('cvv').value,
//       exp_month: document.getElementById('exp_month').value,
//       exp_year: document.getElementById('exp_year').value
//     };
    
//     // トークン生成
//     Payjp.createToken(card, (status, response) => {
//       if (status === 200) {
//         // 出力（本来はサーバへ送信）
//         document.getElementById('card_token').innerHTML = response.card.id;
//       }
//     });
//   });
// }, false);