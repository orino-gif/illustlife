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
    $(elem).next(".p_img").html(imgTag)
  });
})

$(function () {
  showHope();
  // ラジオボタンを選択変更したら実行
  $('input[name="expor[kind]"]').change(function () {
    var pro = $(this).val(); console.log(pro);
    if ('キャラデザ'==pro){ showHope('comp');}
    else if ('構図' == pro){ showHope('rough');}
    else if ('ラフ' == pro){ showHope('line');}
    else if ('線画' == pro){ showHope('coding');}
    else if ('塗り(色分け)' == pro){ showHope('coloring');}
    else if ('プロット' == pro){ showHope('d_name');}
    else if ('ネーム' == pro){ showHope('draft');}
    else if ('下書き' == pro){ showHope('p_draw');}
    else if ('ペン入れ' == pro){ showHope('s_paint');}
  });
  $('input[value="次工程"]', $(this)).prop('checked', true);
  $("#expor_fee").prop("disabled", true);
  $('input[name="expor[hope]"]').change(function () {
    var hope = $(this).val();
    console.log(hope);
    if ('次工程' == hope){$("#expor_fee").prop("disabled", true);}
    else{$("#expor_fee").prop("disabled", false);}
  });
});

function showHope(process){
  $('.g_text').hide();$('.p_img').show();
  $('.comp').hide();$('.rough').hide(); $('.line').hide();
  $('.coding').hide(); $('.coloring').hide(); $('.d_name').hide();
  $('.draft').hide(); $('.p_draw').hide(); $('.s_paint').hide();
  switch(process){
    case 'comp':
      $('.g_text').show(); $('.p_img').hide(); $('.comp').show(); break;
    case 'rough':
      $('.rough').show(); break;
    case 'line':
      $('.line').show(); break;
    case 'coding':
      $('.coding').show(); break;
    case 'coloring':
      $('.coloring').show(); break;
    case 'd_name':
      $('.d_name').show(); break;
    case 'draft':
      $('.draft').show(); break;
    case 'p_draw':
      $('.p_draw').show(); break;
    case 's_paint':
      $('.s_paint').show(); break;
  }
}