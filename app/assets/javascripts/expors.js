// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function () {
  init();
  // ラジオボタンを選択変更したら実行
  $('input[name="expor[kind]"]').change(function () {
    var pro = $(this).val();
    console.log(pro);
    if ('キャラデザ' == pro) { showHope('chara');}
    else if ('背景デザ' == pro) { showHope('bg');}
    else if ('構図' == pro) { showHope('comp');}
    else if ('ラフ' == pro) {showHope('rough');}
    else if ('線画' == pro) {showHope('line');}
    else if ('塗り(色分け)' == pro) { showHope('coding');}
    else if ('塗り(着色)' == pro) { showHope('coloring');}
    else if ('納品' == pro) { showHope('del');}
    else if ('プロット' == pro) { showHope('plot');}
    else if ('ネーム' == pro) { showHope('d_name');}
    else if ('下書き' == pro) { showHope('draft');}
    else if ('ペン入れ' == pro) { showHope('p_draw');}
    else if ('ベタ、トーン' == pro) { showHope('s_paint');}
    else if ('仕上げ(完成)' == pro) { showHope('finish');}
  });

  $('input[name="expor[who]"]').change(function () {
    var who = $(this).val();
    if ('自分で' == who){
      $(".edit_fee").prop("disabled", true);
      $('.reward').hide();
    }
    else{
      $(".edit_fee").prop("disabled", false);
      $('.reward').show();
    }
  });
});

function init(){
  $('.g_text').hide();
  $('.comp').hide();
  $('.d_name').hide();
  $('.draft').hide();
  $('.p_draw').hide();
  $('.s_paint').hide();
  $('.finish').hide();
  $('.reward').hide();
  if (
      'キャラデザ' == $('[name="expor[kind]"]').val() ||
      '背景デザ' == $('[name="expor[kind]"]').val() ||
      'プロット' == $('[name="expor[kind]"]').val()
    ){
    $('.edit_img').hide();
  }else{
    $('.edit_text').hide();
  }
  if ('自分で' == $('[name="expor[who]"]').val()){
    $('.edit_fee').hide();
  }else{
    $('.edit_fee').show();
  }
}

function hide_hope(){
  $('.g_text').hide();
  $('.lll_img').hide();
  $('.comp').hide();
  $('.rough').hide();
  $('.line').hide();
  $('.coding').hide();
  $('.coloring').hide();
  $('.del').hide();
  $('.d_name').hide();
  $('.draft').hide();
  $('.p_draw').hide();
  $('.s_paint').hide();
  $('.finish').hide();
}

function showHope(process){
  hide_hope();
  switch(process){
    case 'chara':
    case 'bg':
      $('.g_text').show();
      $('.comp').show();
      $('.rough').show();
      $('.line').show();
      $('.coding').show();
      $('.coloring').show();
      $('.del').show();
      break;
    case 'comp':
      $('.lll_img').show();
      $('.rough').show();
      $('.line').show();
      $('.coding').show();
      $('.coloring').show();
      $('.del').show();
      break;
    case 'rough':
      $('.lll_img').show();
      $('.line').show();
      $('.coding').show();
      $('.coloring').show();
      $('.del').show();
      break;
    case 'line':
      $('.lll_img').show();
      $('.coding').show();
      $('.coloring').show();
      $('.del').show();
      break;
    case 'coding':
      $('.lll_img').show();
      $('.coloring').show();
      $('.del').show();
      break;
    case 'coloring':
      $('.lll_img').show();
      $('.del').show();
      break;
    case 'del':
      $('.lll_img').show();
      break;
    case 'plot':
      $('.g_text').show();
      $('.d_name').show();
      $('.draft').show();
      $('.p_draw').show();
      $('.s_paint').show();
      $('.finish').show();
      break;
    case 'd_name':
      $('.lll_img').show();
      $('.draft').show();
      $('.p_draw').show();
      $('.s_paint').show();
      $('.finish').show();
      break;
    case 'draft':
      $('.lll_img').show();
      $('.p_draw').show();
      $('.s_paint').show();
      $('.finish').show();
      break;
    case 'p_draw':
      $('.lll_img').show();
      $('.s_paint').show();
      $('.finish').show();
      break;
    case 's_paint':
      $('.lll_img').show();
      $('.finish').show();
      break;
    case 'finish':
      $('.lll_img').show(); 
      break;
  }
}