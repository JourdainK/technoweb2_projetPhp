<ul class="navbar navbar-expand- fixed-top l navbar-primary bg-dark">
    <li><a href="index.php?page=accueil.php">Accueil</a></li>
    <li><a href="index.php?page=shop.php">Shop</a></li>
    <li><a href="index.php?page=video.php">Vidéos</a></li>
    <li><a href="index.php?page=about.php">à propos</a></li>
    <?php if (!isset($_SESSION['client'])): ?>
        <li><a href="index.php?page=login.php">Connexion</a></li>
    <?php else: ?>
        <li><a href="index.php?page=disconnectUser.php">Se déconnecter</a></li>
    <?php endif; ?>
</ul>