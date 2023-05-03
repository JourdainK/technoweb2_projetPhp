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


    //Effacer produit
    $('.delete').click(function () {
        let id_produit = $(this).attr('id');
        console.log('id : ' + id_produit);
        if(confirm('Supprimer ?')) {
            let ligne = $(this).closest("tr");
            ligne.css('background-color','#F00');
            ligne.fadeOut(2000);
            let id_produit = $(this).attr('id');
            let parametre = 'id_produit=' + id_produit;
            let retour = $.ajax({
                type: 'POST',
                data: parametre,
                dataType: 'json',
                url: './lib/php/ajax/ajaxDeleteProduit.php',
                success: function (data) {
                    console.log('success')
                }
            });
        }
    });

    //filtrage de liste

    $('#filtrer').keyup(function () {
        let filtre = $(this).val().toLowerCase();
        $('#tableau tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(filtre) > -1);
        });
    });

    //Tableau éditable
    $('td[id]').click(function () {
        let valeur1 = $(this).text();
        let id_produit = $(this).attr('id');
        let name = $(this).attr('name');
        $(this).blur(function() {
            let valeur2 = $(this).text();
            console.log(valeur2);
            if(valeur1 != valeur2) {
                let parametre = 'champ=' + name + '&valeur=' + valeur2 + '&id_produit=' + id_produit;
                console.log(parametre);
                let retour = $.ajax({
                    type: 'POST',
                    data: parametre,
                    dataType: 'json',
                    url: './lib/php/ajax/ajaxUpdateProduit.php',
                    success: function (data) {
                        console.log('success');
                    }
                });
            }
        });
        console.log(name);
    });

    $('#submit_form').text('Insérer');


    $('#nomInput').blur(function(){
        let nom_prod = $(this).val();
        if(nom_prod!= ''){
            var parametre ="nom_produit="+nom_prod;
            $.ajax({
                type: 'POST',
                data: parametre,
                dataType: 'json',
                url: './lib/php/ajax/ajaxRechercheProd.php',
                success: function (data){
                    console.log("success");
                    $('#descriptInput').val(data[0].description);
                    if($('#descriptInput').val() != ''){
                        console.log(data[0].prix);
                        $('#prixInput1').val(data[0].prix);
                        $('#submit_form').text("Editer");
                    }
                }
            })
        }

    })


    $('#submit_prod').click(function (event){
       event.preventDefault();
       event.stopPropagation();
       let nom_prod = $('#nomInput').val();
       let categorie = $('#cat').val();
       let description = $('#descriptInput').val();
       let prix = $('#prixInput1').val();
       let phoro = $('#file').val();
       phoro = trim(phoro,'C:\\fakepath\\');
       let photo = '..\\image\\'+ phoro;
       let bouton = $(this).text();
       let parametre = "nom_produit="+ nom_prod +"&description=" + description + "&prix=" + prix + "&photo=" + photo + "&id_categorie=" + categorie;
       if(bouton != "Editer") {
           $.ajax({
               type : 'POST',
               data: parametre,
               dataType: 'json',
               url: './lib/php/ajax/ajaxAjoutProduit.php',
               success: function(data){
                   console.log('Ajouté');
                   $('#nomInput').val('');
                   $('#cat').val('');
                   $('#descriptInput').val('');
                   $('#prixInput1').val('');
                   $('#file').val('');
                   $('#inDB').html("<span class='txtGras'>Insertion effectuée</span>");

               }
           });
       }


    });





})