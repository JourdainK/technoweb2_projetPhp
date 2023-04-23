<?php
$prod = new produits($cnx);
$produits = $prod->getAllProduits();

$nbrprod = count($produits);

if(isset($_POST['submit'])) {
    //TODO traitement PHP si JS DISPO
    // -> bouton -> si submit
    // cacher bouton avec JS -> si pas JS bouton apparaitra
}
?>


<div class="container pt-2 text-center">
    <div class="row pt-5 ">
        <h2>Gestion des produits</h2>
    </div>
    <div class="row p-3" style="width: 20%">
        <input type="text" id="filtrer" placeholder="Filtrer"/>
    </div>
    <div class="row align-content-center" id="ensemble">

        <table class="table .table-striped table-dark p-0" id="tableau">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Nom</th>
                <th scope="col">description</th>
                <th scope="col">Prix</th>
                <th scope="col">Image</th>
                <th scope="col">categorie</th>
                <th scope="col">&nbsp;</th>
            </tr>
            </thead>
            <tbody class="text-light">
            <form action="<?php $_SERVER['PHP_SELF']; ?>" method="POST">
                <?php
                for ($i = 0; $i < $nbrprod; $i++) {
                    ?>
                    <tr>
                        <td><?php print $produits[$i]->id_produit; ?></td>
                        <td contenteditable="true" name="nom_produit"
                            id="<?php print $produits[$i]->id_produit; ?>"><?php print $produits[$i]->nom_produit; ?></td>
                        <td contenteditable="true" name="description"
                            id="<?php print $produits[$i]->id_produit; ?>"><?php print $produits[$i]->description; ?></td>
                        <td contenteditable="true" name="prix"
                            id="<?php print $produits[$i]->id_produit; ?>"><?php print $produits[$i]->prix; ?> </td>
                        <td contenteditable="true" name="photo"
                            id="<?php print $produits[$i]->id_produit; ?>"><img src="../<?php print $produits[$i]->photo; ?>" class="img-fluid rounded-start" alt="..." style="width: 35%"><br><?php print $produits[$i]->photo; ?></td>
                        <td contenteditable="true" name="id_categorie"
                            id="<?php print $produits[$i]->id_produit; ?>"><?php print $produits[$i]->id_categorie; ?> </td>
                        <td><img src="./images/delete.jpg" id="<?php print $produits[$i]->id_produit; ?>" class="delete" alt="delete "/></td>
                    </tr>
                    <?php
                }
                ?>
            </form>
            <input type="submit" name="submit" id="submit" value="Envoyer" style="width: 20%;"/>
            </tbody>
        </table>

        <div id="illustration">
            &nbsp;
        </div>
    </div>
</div>
