$(document).ready(function () {


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

    $('#editer_ajouter').text('Insérer');


    $('#nom_produit').blur(function(){
        let nom_prod = $(this).val();
        if(nom_prod != ''){
            var parametre ="nom_produit="+nom_prod;
            $.ajax({
                type: 'POST',
                data: parametre,
                dataType: 'json',
                url: './lib/php/ajax/ajaxRechercheProd.php',
                success: function(data){
                    console.log("success");
                    $('#descriptInput').val(data[0].description);
                    $('#prixInput').val(data[0].prix);
                    if($('#descriptInput').val() != ''){
                        $('#prixInput').val(data[0].prix);
                        //Got help From ChatGpt to handle the radio button
                        var catId = data[0].id_categorie;
                        $('input[name="id"]').filter('[value="' + catId + '"]').prop('checked', true);
                        $('#editer_ajouter').text("Editer");
                    }
                }
            });
        }

    });


    $('#editer_ajouter').click(function (event){
        event.preventDefault();
        event.stopPropagation();
        var formData = new FormData(this);


        let nom_prod = $('#nom_produit').val();
        let categorie = $('#cat').val();
        let description = $('#descriptInput').val();
        let prix = $('#prixInput').val();
        let bouton = $(this).text();
        let parametre = "nom_produit="+ nom_prod +"&description=" + description + "&prix=" + prix  + "&id_categorie=" + categorie;
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
                    $('#prixInput').val('');
                    $('#file').val('');
                    $('#inDB').html("<span class='txtGras'>Insertion effectuée</span>");

                }
            });
        }

    });


})
