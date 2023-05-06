$(document).ready(function () {

    //bouton description des livres >> Faire apparaitre ou disparaitre la description
    var but13;
    $('#book13').hide();


    var book13but=0;
    $('#book13but').click(function () {
        if(book13but === 0){
            $('#book13').fadeIn(2000);
            $('#book13').slideDown();
            book13but = 1;
        }
        if(book13but ===1){
            $('#book13but').click(function () {
                $('#book13').hide();
                book13but = 0;
            });
        }
    });

    var but14;
    $('#book14').hide();


    var book14but=0;
    $('#book14but').click(function () {
        if(book14but === 0){
            $('#book14').fadeIn(2000);
            $('#book14').slideDown();
            book14but = 1;
        }
        if(book14but ===1){
            $('#book14but').click(function () {
                $('#book14').hide();
                book14but = 0;
            });
        }
    });

    var but15;
    $('#book15').hide();


    var book15but=0;
    $('#book15but').click(function () {
        if(book15but === 0){
            $('#book15').fadeIn(2000);
            $('#book15').slideDown();
            book15but = 1;
        }
        if(book15but ===1){
            $('#book15but').click(function () {
                $('#book15').hide();
                book15but = 0;
            });
        }
    });

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
                $('#book16').hide();
                book16but = 0;
            });
        }
    });



})