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
    `<img class="l_f_rect fit_con"
    $Xlarge; src='${fileReader.result}'>`
    let imgTag2 = 
    `<img class="m_f_rect fit_con"
    $Xlarge; src='${fileReader.result}'>`
    //画像をプレビュー
    $(elem).next(".e_img,.edit_img,.p_img").html(imgTag)
    $(elem).next(".e_img,.edit_img,.p_img").html(imgTag2)
  });
})

$(function () {
  // showHope();
  $('.g_text').hide();$('.e_img').show();
  $('.comp').hide();$('.rough').show(); $('.line').show(); $('.coding').show();
  $('.coloring').show(); $('.del').show();$('.d_name').hide();
  $('.draft').hide(); $('.p_draw').hide(); $('.s_paint').hide();
  $('.finish').hide();
  $('.c_text').hide();
  
  if ('キャラ・背景デザ(文字)' == $("#expor_kind").val()){
    $('.edit_img').hide();
    $('.edit_text').show();
    $('.c_text').hide();
  }else{
    $('.edit_img').show();
    $('.edit_text').hide();
  }
  
  // ラジオボタンを選択変更したら実行
  $('input[name="expor[kind]"]').change(function () {
    var pro = $(this).val(); console.log(pro);
    if ('キャラ・背景デザ(文字)'==pro){ showHope('chara');}
    else if ('構図' == pro){ showHope('comp');}
    else if ('ラフ' == pro){ showHope('rough');}
    else if ('線画' == pro){ showHope('line');}
    else if ('塗り(色分け)' == pro){ showHope('coding');}
    else if ('塗り(着色)' == pro){ showHope('coloring');}
    else if ('納品' == pro){ showHope('del');}
    else if ('プロット' == pro){ showHope('plot');}
    else if ('ネーム' == pro){ showHope('d_name');}
    else if ('下書き' == pro){ showHope('draft');}
    else if ('ペン入れ' == pro){ showHope('p_draw');}
    else if ('ベタ塗り、トーン貼り' == pro){ showHope('s_paint');}
    else if ('仕上げ(完成)' == pro){ showHope('finish');}
  });
  $("#expor_fee").prop("disabled", true);
  $("#expor_kind").change(function() {
    var val = $(this).val();
    console.log(val);
    if ('キャラ・背景デザ(文字)' == val || 'プロット' == val){
      $('.edit_img').hide();
      $('.edit_text').show();
      $('.c_text').hide();
      
    }
    else{
      $('.edit_img').show();
      $('.edit_text').hide();
    }
  });
  $('input[name="expor[who]"]').change(function () {
    var who = $(this).val();
    // console.log(who);
    if ('自分で' == who){
      $("#expor_fee").prop("disabled", true);
      $(".edit_fee").prop("disabled", true);
      $('.c_text').hide();
    }
    else{
      $("#expor_fee").prop("disabled", false);
      $(".edit_fee").prop("disabled", false);
      var aaa = $("input[name='expor[kind]']:checked").val();
      console.log(aaa);
      if ('キャラ・背景デザ(文字)' != aaa && 'プロット' != aaa ){
        $('.c_text').show();
      }
      }
  });
});

function showHope(process){
  $('.g_text').hide();$('.e_img').show();
  $('.comp').hide();$('.rough').hide(); $('.line').hide(); $('.coding').hide();
  $('.coloring').hide(); $('.del').hide();$('.d_name').hide();
  $('.draft').hide(); $('.p_draw').hide(); $('.s_paint').hide();
  $('.finish').hide();
  switch(process){
    case 'chara':
      $('.g_text').show(); $('.e_img').hide(); 
      $('.comp').show(); $('.rough').show(); $('.line').show();
      $('.coding').show();$('.coloring').show(); $('.del').show();
      $('input[name=hope]').val(['comp']);$('.c_text').hide();
      break;
    case 'comp':
      $('.rough').show(); $('.line').show(); $('.coding').show();
      $('.coloring').show(); $('.del').show();$('.c_text').show();
      break;
    case 'rough':
      $('.line').show();$('.coding').show();
      $('.coding').show(); $('.coloring').show(); $('.del').show();
      $('input[name=hope]').val(['line']);$('.c_text').show();
      break;
    case 'line':
      $('.coding').show(); $('.coloring').show(); $('.del').show();
      $('.c_text').show();
      break;
    case 'coding':
      $('.coloring').show(); $('.del').show();$('.c_text').show();
      break;
    case 'coloring':
      $('.del').show();$('.c_text').show();
      break;
    case 'plot':
      $('.g_text').show(); $('.e_img').hide();
      $('.d_name').show(); $('.draft').show(); $('.p_draw').show();
      $('.s_paint').show();$('.finish').show();$('.c_text').hide();
      break;
    case 'd_name':
      $('.g_text').hide(); $('.e_img').show();
      $('.draft').show(); $('.p_draw').show(); $('.s_paint').show();
      $('.finish').show();$('.c_text').show();
      break;
    case 'draft':
      $('.g_text').hide(); $('.e_img').show();
      $('.p_draw').show(); $('.s_paint').show(); $('.finish').show();
      $('.c_text').show();
      break;
    case 'p_draw':
      $('.g_text').hide(); $('.e_img').show();
      $('.s_paint').show(); $('.finish').show();$('.c_text').show();
      break;
    case 's_paint':
      $('.g_text').hide(); $('.e_img').show();
      $('.finish').show(); $('.c_text').show();
      break;
    case 'finish':
      $('.g_text').hide(); $('.e_img').show(); $('.c_text').show();
      break;
  }
}