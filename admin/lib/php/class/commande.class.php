<?php

class Commande extends Hydrate {
    private $_db;
    private $data = array();
    private $result;

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }

    public function addCommande($id_commande, $prix_comm, $statut, $date_commande, $id_client){
        try {
            $query = "INSERT INTO commande(id_commande, prix_comm, statut, date_commande, id_client) VALUES (:id_commande, :prix_comm, :statut, :date_commande, :id_client)";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_commande', $id_commande);
            $res->bindValue(':prix_comm', $prix_comm);
            $res->bindValue(':statut', $statut);
            $res->bindValue(':date_commande', $date_commande);
            $res->bindValue(':id_client', $id_client);

            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return $data;
            }
            else{
                return null;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }


}