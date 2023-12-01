import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:security_info_project/src/models/infography.dart';
import 'package:security_info_project/src/models/video_class.dart';

class LocalData {
  List<Infography> get infographies => [
        Infography(
            title: "Seguridad en línea",
            image: "assets/images/infography/infography_online_security.jpg",
            description: "A ta perrotototototototototototototototototote"),
        Infography(
            title: "Ataques de phishing",
            image: "assets/images/infography/infography_phishing.jpg",
            description: "A ta perrotototototototototototototototototote"),
        Infography(
            title: "Fraudes en línea",
            image: "assets/images/infography/infografy_iot_security.jpg",
            description: "A ta perrotototototototototototototototototote"),
        Infography(
            title: "Identidad personal",
            image: "assets/images/infography/infography_personal_identity.jpg",
            description: "A ta perrotototototototototototototototototote"),
        Infography(
            title: "Contraseñas",
            image: "assets/images/infography/infography_secure_passwords.jpg",
            description: "A ta perrotototototototototototototototototote"),
        Infography(
            title: "Actualizaciones",
            image: "assets/images/infography/infography_updates_importance.jpg",
            description: "A ta perrotototototototototototototototototote"),
      ];

  Future<List<VideoClass>> getClasses() async {
    List<VideoClass> videoClasses = [];

    videoClasses = [
      VideoClass(
          title: "Seguridad en línea",
          summary:
              "La seguridad en línea es esencial en nuestra era digital. Adoptar prácticas seguras, como contraseñas robustas y actualizaciones frecuentes, es clave. La colaboración entre usuarios, empresas y gobiernos, junto con la adopción de tecnologías avanzadas, es fundamental para hacer frente a las amenazas en constante evolución.",
          videoUrl: dotenv.env['URL_VIDEO1']!,
          isCompleted: true,
          percentage: 100,
          questionPoolPath: 'assets/json/pool_preguntas_video1.json'),
      VideoClass(
          title: "Escenarios de phishing",
          summary: "La seguridad en línea es esencial en nuestra era digital. Adoptar prácticas seguras, como contraseñas robustas y actualizaciones frecuentes, es clave. La colaboración entre usuarios, empresas y gobiernos, junto con la adopción de tecnologías avanzadas, es fundamental para hacer frente a las amenazas en constante evolución.\n\nEl phishing representa una amenaza persistente en línea, donde los atacantes intentan engañar a los usuarios para obtener información confidencial, como contraseñas o datos financieros. Los escenarios comunes incluyen correos electrónicos falsos que parecen legítimos, páginas web fraudulentas y mensajes engañosos en redes sociales. Los usuarios deben estar atentos y verificar cuidadosamente la autenticidad de las comunicaciones en línea para evitar caer en estas trampas digitales. La conciencia y la educación son fundamentales para reconocer y prevenir los intentos de phishing, contribuyendo así a mantener un entorno en línea más seguro.\n",
          videoUrl: dotenv.env['URL_VIDEO2']!,
          isCompleted: false,
          percentage: 50,
          questionPoolPath: 'assets/json/pool_preguntas_video1.json'),
      VideoClass(
          title: "Fraudes en línea",
          summary: "Los fraudes en línea son amenazas constantes en el mundo digital, donde los delincuentes utilizan diversas tácticas para engañar a usuarios desprevenidos. Estos fraudes pueden incluir esquemas de inversión falsos, ofertas engañosas, y suplantación de identidad en plataformas de compras en línea. Es crucial que los usuarios estén alerta ante situaciones sospechosas, verifiquen la autenticidad de las transacciones y eviten proporcionar información personal o financiera sin una validación adecuada.\n\nLa educación sobre los tipos de fraudes en línea y el fortalecimiento de las medidas de seguridad son esenciales para protegerse contra estas amenazas digitales en evolución constante.\n",
          videoUrl: dotenv.env['URL_VIDEO3']!,
          isCompleted: true,
          percentage: 50,
          questionPoolPath: 'assets/json/pool_preguntas_video3.json'),
      VideoClass(
          title: "Protección de identidad personal",
          summary: "La protección de la identidad personal es crucial en el entorno digital actual, donde los riesgos de robo de identidad son constantes. Los usuarios deben implementar medidas de seguridad como contraseñas fuertes, autenticación de dos factores y evitar compartir información sensible en sitios no seguros. La conciencia sobre las tácticas de phishing y la supervisión regular de actividades financieras son prácticas esenciales para detectar y prevenir el uso no autorizado de la información personal. Además, el uso responsable de la información en línea y la adopción de herramientas de seguridad contribuyen significativamente a resguardar la identidad personal en el mundo digital.\n\nLa protección de la identidad personal es un esfuerzo continuo que requiere la colaboración entre usuarios, empresas y organismos gubernamentales para garantizar un entorno en línea más seguro y confiable.",
          videoUrl: dotenv.env['URL_VIDEO4']!,
          isCompleted: false,
          percentage: 50,
          questionPoolPath: 'assets/json/pool_preguntas_video1.json'),
      VideoClass(
          title: "Importancia de las contraseñas fuertes",
          summary: "La importancia de tener contraseñas fuertes radica en la protección efectiva de cuentas y datos personales en línea. Contraseñas robustas actúan como una primera línea de defensa contra el acceso no autorizado, dificultando a los ciberdelincuentes descifrarlas. Al utilizar combinaciones únicas de caracteres, incluyendo letras, números y símbolos, se fortalece la seguridad y se reduce el riesgo de violaciones de seguridad. Es esencial evitar contraseñas predecibles, como fechas de nacimiento o secuencias comunes, para garantizar una mayor resistencia frente a ataques de fuerza bruta y otros métodos de intrusión.\n\nAdemás, la práctica de cambiar regularmente las contraseñas y utilizar autenticación de dos factores añade capas adicionales de protección. La conciencia sobre la importancia de contraseñas fuertes, junto con la educación continua sobre prácticas seguras, contribuye a mantener un entorno en línea más seguro y protegido contra amenazas cibernéticas.",
          videoUrl: dotenv.env['URL_VIDEO5']!,
          isCompleted: true,
          percentage: 50,
          questionPoolPath: 'assets/json/pool_preguntas_video5.json'),
      VideoClass(
          title: "Actualizaciones periódicas",
          summary: "Las actualizaciones periódicas de software son fundamentales para mantener la seguridad en línea. Estas actualizaciones no solo ofrecen nuevas funciones, sino que también corrigen vulnerabilidades y brechas de seguridad existentes. Al asegurarse de que el sistema operativo, programas y aplicaciones estén actualizados, los usuarios reducen significativamente el riesgo de ser víctimas de exploits y ataques cibernéticos.\n\nLa importancia de las actualizaciones periódicas radica en su capacidad para fortalecer las defensas digitales, mitigando riesgos y mejorando la resistencia contra amenazas en constante evolución. La conciencia sobre la necesidad de mantener el software actualizado, junto con la configuración de actualizaciones automáticas cuando sea posible, es esencial para garantizar una protección efectiva en el entorno digital.",
          videoUrl: dotenv.env['URL_VIDEO6']!,
          isCompleted: true,
          percentage: 100,
          questionPoolPath: 'assets/json/pool_preguntas_video6.json'),
    ];

    return videoClasses;
  }
}
