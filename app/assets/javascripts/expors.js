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
    $(elem).next(".e_img").html(imgTag)
  });
})

$(function () {
  showHope();
  // ラジオボタンを選択変更したら実行
  $('input[name="expor[kind]"]').change(function () {
    var pro = $(this).val(); console.log(pro);
    if ('キャラ・背景デザ(文字)'==pro){ showHope('chara');}
    else if ('構図' == pro){ showHope('comp');}
    else if ('ラフ' == pro){ showHope('rough');}
    else if ('線画' == pro){ showHope('line');}
    else if ('塗り(色分け)' == pro){ showHope('coding');}
    else if ('塗り(着色)' == pro){ showHope('coloring');}
    else if ('プロット' == pro){ showHope('d_name');}
    else if ('ネーム' == pro){ showHope('draft');}
    else if ('下書き' == pro){ showHope('p_draw');}
    else if ('ペン入れ' == pro){ showHope('s_paint');}
  });
  
  $("#expor_fee").prop("disabled", true);
  $('input[name="expor[who_id]"]').change(function () {
    var who_id = $(this).val();
    console.log(who_id);
    if (0 == who_id){$("#expor_fee").prop("disabled", true);}
    else{$("#expor_fee").prop("disabled", false);}
  });
});

function showHope(process){
  $('.g_text').hide();$('.e_img').show();
  $('.comp').hide();$('.rough').hide(); $('.line').hide();
  $('.coding').hide(); $('.coloring').hide(); $('.d_name').hide();
  $('.draft').hide(); $('.p_draw').hide(); $('.s_paint').hide();
  switch(process){
    case 'chara':
      $('.g_text').show(); $('.e_img').hide(); 
      $('.comp').show(); $('.rough').show(); $('.line').show();
      $('.coding').show();$('.coloring').show();
      break;
    case 'comp':
      $('.g_text').show(); $('.e_img').hide(); 
      $('.comp').show(); $('.rough').show(); $('.line').show();
      $('.coding').show();$('.coloring').show();
      break;
    case 'rough':
      $('.rough').show();
      $('.rough').hide(); $('.line').show();$('.coding').show();
      $('.coloring').show(); $('.coloring').show(); $('.d_name').show();
      $('.draft').show(); $('.p_draw').show(); $('.s_paint').show();
      break;
    case 'line':
      $('.line').show(); break;
    case 'coding':
      $('.coding').show(); break;
    case 'coloring':
      $('.coloring').show(); break;
    case 'd_name':
      $('.d_name').show(); $('.g_text').show(); $('.e_img').hide();break;
    case 'd_name':
      $('.d_name').show(); $('.g_text').show(); $('.e_img').hide();break;
    case 'draft':
      $('.draft').show(); break;
    case 'p_draw':
      $('.p_draw').show(); break;
    case 's_paint':
      $('.s_paint').show(); break;
  }
}