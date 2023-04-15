$(document).ready(function () {

    console.log('HELLLOOOOOOO');
    var but16;
    $('#book16').hide();


    var book16but=0;
    $('#book16but').click(function () {
        if(book16but === 0){
            $('#book16').fadeIn(2000);
            $('#book16').slideDown();
            book16but = 1;
        }
        if(book16but ===1){
            $('#book16but').click(function () {
                $('#book16').hide(1000);
                book16but = 0;
            });
        }
    });
//TODO do that for all the books -> better looking on the page, description are too long



})