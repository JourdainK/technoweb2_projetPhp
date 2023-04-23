<?php
$prods = new produits($cnx);
$produits = $prods->getAllProduits();
//var_dump($produits);
$cnt = count($produits);
//print 'count : '.$cnt;


$dvd = new dvd($cnx);
$dvds = $dvd->getAllDvds();
$cntdvd = count($dvds);
//print 'Nombre de dvd = '.$cntdvd;

$livre = new Livre($cnx);
$livres = $livre->getAllLivres();
$cntlivre = count($livres);
//var_dump($livres);

//TODO make shopping cart

$goodie = new Goodies($cnx);
$goodies = $goodie->getAllGoodies();
//var_dump($goodies);
$cntgoodies = count($goodies);

?>

<div class="container pt-5">

    <div class="row">
       <div class="col-8">
           <div class="row text-light text-center justify-content-center">
               <h3>Dvd</h3>
               <?php
               for ($i = 0; $i < $cntdvd; $i++) {
                   ?>

                   <div class="card mb-3 p-2 m-3" style="max-width: 400px;">
                       <div class="row g-0">
                           <div class="col-md-4">
                               <img src="../<?php print $dvds[$i]->photo; ?>" class="img-fluid rounded-start" alt="...">
                           </div>
                           <div class="col-md-8">
                               <div class="card-body">
                                   <h5 class="card-title text-black"><?php print $dvds[$i]->nom_produit;?></h5>
                                   <p class="card-text text-black">Prix : <?php print $dvds[$i]->prix;?> €</p>
                                   <p class="card-text"><small class="text-muted"><?php print $dvds[$i]->description; ?></small></p>
                               </div>
                           </div>
                       </div>
                   </div>



                   <?php
               }
               ?>
           </div>

           <div class="row text-light text-center justify-content-center">
               <h3>Livres</h3>
               <?php
               for ($i = 0; $i < $cntlivre; $i++) {
                   ?>

                   <div class="card mb-3 p-2 m-3 mx-auto" style="max-width: 400px;">
                       <div class="col g-0">
                           <div class="row-md-2 ">
                               <img src="../<?php print $livres[$i]->photo; ?>" class="img-fluid rounded-start" alt="..." style="max-width: 180px;">
                           </div>
                           <div class="row-md-10">
                               <div class="card-body">
                                   <h5 class="card-title text-black"><?php print $livres[$i]->nom_produit;?></h5>
                                   <p class="card-text text-black">Prix : <?php print $livres[$i]->prix;?> €</p>
                                   <button  id="book<?php print $livres[$i]->id_produit;?>but" type="button" class="btn btn-primary btn-sm">Description</button>
                                   <p id="book<?php print $livres[$i]->id_produit;?>" class="card-text"><small class="text-muted"><?php print $livres[$i]->description; ?></small></p>
                               </div>
                           </div>
                       </div>
                   </div>



                   <?php
               }
               ?>
           </div>

           <div class="row text-light text-center justify-content-center">
               <h3>Goodies</h3>
               <?php
               for ($i = 0; $i < $cntgoodies; $i++) {
                   ?>

                   <div class="card mb-3 p-2 m-3" style="max-width: 400px;">
                       <div class="row g-0">
                           <div class="col-md-4">
                               <img src="../<?php print $goodies[$i]->photo; ?>" class="img-fluid rounded-start" alt="...">
                           </div>
                           <div class="col-md-8">
                               <div class="card-body">
                                   <h5 class="card-title text-black"><?php print $goodies[$i]->nom_produit;?></h5>
                                   <p class="card-text text-black">Prix : <?php print $goodies[$i]->prix;?> €</p>
                                   <p class="card-text"><small class="text-muted"><?php print $goodies[$i]->description; ?></small></p>
                               </div>
                           </div>
                       </div>
                   </div>



                   <?php
               }
               ?>
           </div>

       </div>

        <div class="col">
            <div class="panier">
                <p> blablabla PANIER WILL BE HERE</p>
            </div>
        </div>

    </div>



</div>

