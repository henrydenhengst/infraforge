<?php
/**
 * Fallback Mail Script voor Linux Café Haarlem
 * Beveiligd tegen header-injectie en XSS.
 */
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $to = "info@linuxcafehaarlem.nl";
    $subject = "Contactformulier LCH Website";
    
    // Validatie en Sanitisatie
    $name = strip_tags(trim($_POST["name"]));
    $email = filter_var(trim($_POST["email"]), FILTER_SANITIZE_EMAIL);
    $message = htmlspecialchars(trim($_POST["message"]));

    if (empty($name) || empty($message) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        http_response_code(400);
        echo "Validatie mislukt. Controleer uw invoer.";
        exit;
    }

    $email_content = "Naam: $name\n";
    $email_content .= "Email: $email\n\n";
    $email_content .= "Bericht:\n$message\n";

    $headers = "From: $name <$email>\r\n";
    $headers .= "Reply-To: $email\r\n";
    $headers .= "X-Mailer: PHP/" . phpversion();

    if (mail($to, $subject, $email_content, $headers)) {
        echo "Succes: Uw bericht is verzonden naar het Linux Café.";
    } else {
        http_response_code(500);
        echo "Fout: De server kon de e-mail niet verzenden.";
    }
} else {
    echo "Dit script accepteert alleen POST-aanvragen.";
}
?>
