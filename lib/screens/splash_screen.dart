import 'package:flashcard/models/flashcard_item.dart';
import 'package:flashcard/models/flashcard_provider.dart';
import 'package:flashcard/models/question_answer_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String appName = 'Flashcard';
final String copyright = '${getCurrentYear()} \u00a9 Poralcode';

int getCurrentYear() {
  return DateTime.now().year;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      //This is just a sample data.
      Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(FlashcardItem(0, 0, 0, 0, 'Medical Equipment', [
        QuestionAnswerItem(0, false, 'What is an EKG machine used for?', '', 'An EKG machine is used to monitor the electrical activity of the heart.'),
        QuestionAnswerItem(1, false, 'What does a stethoscope do?', '', 'A stethoscope is used to listen to internal sounds in the body, such as heart and lung sounds.'),
        QuestionAnswerItem(2, false, 'What is a defibrillator?', '', 'A defibrillator is a device used to deliver an electric shock to the heart to restore normal rhythm.'),
        QuestionAnswerItem(3, false, 'What is the purpose of an IV (intravenous) drip?', '', 'An IV drip is used to administer fluids, medications, and nutrients directly into the bloodstream.'),
        QuestionAnswerItem(4, false, 'What is a blood pressure cuff used for?', '', 'A blood pressure cuff is used to measure a patient\'s blood pressure.'),
        QuestionAnswerItem(5, false, 'What is an MRI machine?', '', 'An MRI machine is used for non-invasive imaging of the internal structures of the body.'),
        QuestionAnswerItem(6, false, 'What is a nebulizer used for?', '', 'A nebulizer is used to convert liquid medication into a fine mist for inhalation.'),
        QuestionAnswerItem(7, false, 'What is a surgical scalpel?', '', 'A surgical scalpel is a small, sharp knife used for surgical procedures.'),
        QuestionAnswerItem(8, false, 'What is a pulse oximeter?', '', 'A pulse oximeter is used to measure the oxygen saturation of the blood.'),
        QuestionAnswerItem(9, false, 'What are latex gloves used for in a medical setting?', '', 'Latex gloves are used for hand protection and hygiene in medical procedures.'),
      ]));

      Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(FlashcardItem(0, 0, 0, 0, 'OOP Quiz Preparation', [
        QuestionAnswerItem(0, false, 'What is OOP?', '', 'Object-Oriented Programming is a programming paradigm that uses objects to represent and manipulate data and functionality.'),
        QuestionAnswerItem(1, false, 'What are the key principles of OOP?', '', 'The key principles of OOP are encapsulation, inheritance, and polymorphism.'),
        QuestionAnswerItem(2, false, 'What is a class?', '', 'A class is a blueprint for creating objects in OOP. It defines the structure and behavior of objects.'),
        QuestionAnswerItem(3, false, 'What is an object in OOP?', '', 'An object is an instance of a class that contains both data (attributes) and methods (functions).'),
        QuestionAnswerItem(4, false, 'What is encapsulation?', '', 'Encapsulation is the concept of bundling data (attributes) and methods that operate on the data into a single unit, known as a class.'),
        QuestionAnswerItem(5, false, 'What is inheritance in OOP?', '', 'Inheritance is a mechanism that allows a class to inherit properties and behaviors from another class.'),
        QuestionAnswerItem(6, false, 'What is polymorphism?', '', 'Polymorphism is the ability of different objects to respond to the same method or message in a way that is specific to their individual class.'),
        QuestionAnswerItem(7, false, 'What is a constructor?', '', 'A constructor is a special method used to initialize an object when it is created.'),
        QuestionAnswerItem(8, false, 'What is a superclass and subclass in inheritance?', '', 'A superclass (or base class) is a class that is extended or inherited from by another class, known as a subclass.'),
        QuestionAnswerItem(9, false, 'What is method overriding?', '', 'Method overriding is the ability of a subclass to provide a specific implementation of a method that is already defined in its superclass.'),
        QuestionAnswerItem(10, false, 'What is abstraction in OOP?', '', 'Abstraction is the process of simplifying complex reality by modeling classes based on their essential properties and behaviors.'),
        QuestionAnswerItem(11, false, 'What is a static method in a class?', '', 'A static method is a method that belongs to the class itself, rather than to instances of the class.'),
        QuestionAnswerItem(12, false, 'What is a UML diagram?', '', 'A UML (Unified Modeling Language) diagram is a standardized visual representation of the design of a system using OOP concepts.'),
        QuestionAnswerItem(13, false, 'What is the "this" keyword in OOP?', '', 'The "this" keyword refers to the current instance of a class and is used to access its attributes and methods.'),
        QuestionAnswerItem(14, false, 'What is a design pattern in OOP?', '', 'A design pattern is a general reusable solution to a common problem in software design.'),
        QuestionAnswerItem(15, false, 'What is the difference between composition and inheritance?', '', 'Composition is a design principle where a class contains objects of other classes, while inheritance is a mechanism for creating new classes based on existing classes.'),
        QuestionAnswerItem(16, false, 'What is a private, protected, and public access modifier?', '', 'Private restricts access to the class itself, protected allows access within the class and its subclasses, and public allows access from anywhere.'),
        QuestionAnswerItem(17, false, 'What is a method signature?', '', 'A method signature consists of the method name and its parameter types, but not its return type.'),
        QuestionAnswerItem(18, false, 'What is an abstract class?', '', 'An abstract class is a class that cannot be instantiated and is typically used as a base class for other classes.'),
        QuestionAnswerItem(19, false, 'What is an interface?', '', 'An interface defines a contract for classes that implement it, specifying the methods they must provide.'),
        QuestionAnswerItem(20, false, 'What is multiple inheritance?', '', 'Multiple inheritance is a feature that allows a class to inherit from more than one class.'),
        QuestionAnswerItem(21, false, 'What is the "super" keyword in OOP?', '', 'The "super" keyword is used to call a method or constructor in a superclass.'),
        QuestionAnswerItem(22, false, 'What is a virtual method?', '', 'A virtual method is a method that can be overridden by subclasses in languages that support polymorphism.'),
        QuestionAnswerItem(23, false, 'What is method overloading?', '', 'Method overloading is the ability to define multiple methods with the same name but different parameters in the same class.'),
        QuestionAnswerItem(24, false, 'What is a package in OOP?', '', 'A package is a way to organize related classes and interfaces into a namespace.'),
        QuestionAnswerItem(25, false, 'What is a singleton pattern?', '', 'The singleton pattern ensures that a class has only one instance and provides a global point of access to that instance.'),
        QuestionAnswerItem(26, false, 'What is the role of a destructor in OOP?', '', 'A destructor is a special method used to clean up resources and memory when an object is destroyed.'),
        QuestionAnswerItem(27, false, 'What is a constructor chaining?', '', 'Constructor chaining is the process of calling one constructor from another in the same class.'),
        QuestionAnswerItem(28, false, 'What is a class diagram in UML?', '', 'A class diagram in UML provides an overview of the structure and relationships among classes in a system.'),
        QuestionAnswerItem(29, false, 'What is a composition relationship in UML?', '', 'Composition is a relationship where one class is composed of one or more other classes and is responsible for their lifetime.'),
      ]));

      Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(FlashcardItem(0, 0, 0, 0, 'Mandarin Language', [
        QuestionAnswerItem(0, false, 'What is Mandarin Chinese?', '', 'Mandarin Chinese, often referred to simply as Mandarin, is the standard and official language of China.'),
        QuestionAnswerItem(1, false, 'How many tones are there in Mandarin?', '', 'Mandarin Chinese has four main tones and one neutral tone, making a total of five tones.'),
        QuestionAnswerItem(2, false, 'What is pinyin?', '', 'Pinyin is the official romanization system used for writing Chinese characters based on their pronunciation.'),
        QuestionAnswerItem(3, false, 'What are Chinese characters?', '', 'Chinese characters, also known as Hanzi, are logograms used in the writing of the Chinese language.'),
        QuestionAnswerItem(4, false, 'How many Chinese characters are there?', '', 'There are thousands of Chinese characters, but most people only need to learn around 3,000 to 4,000 to read and write fluently.'),
        QuestionAnswerItem(5, false, 'What is the difference between traditional and simplified Chinese characters?', '', 'Traditional Chinese characters are more complex and are used in Taiwan, Hong Kong, and Macau, while simplified Chinese characters are used in mainland China.'),
        QuestionAnswerItem(6, false, 'What is the Hanyu Shuiping Kaoshi (HSK) exam?', '', 'The HSK is a standardized test of Chinese language proficiency used for non-native speakers.'),
        QuestionAnswerItem(7, false, 'What are the four tones in Mandarin?', '', 'The four main tones in Mandarin are the first tone (high and level), the second tone (rising), the third tone (low and dipping-then-rising), and the fourth tone (sharp falling).'),
        QuestionAnswerItem(8, false, 'What is the neutral tone in Mandarin?', '', 'The neutral tone is a tone with a light and short pronunciation and is often used with unstressed syllables.'),
        QuestionAnswerItem(9, false, 'How do you say "hello" in Mandarin?', '', 'The common way to say "hello" in Mandarin is "你好" (nǐ hǎo).'),
        QuestionAnswerItem(10, false, 'What is the most common measure word in Mandarin?', '', 'The measure word "个" (gè) is one of the most commonly used measure words in Mandarin.'),
        QuestionAnswerItem(11, false, 'What is a Chinese radical?', '', 'A Chinese radical is a component of a Chinese character that often provides clues to its meaning or pronunciation.'),
        QuestionAnswerItem(12, false, 'What is the importance of strokes in writing Chinese characters?', '', 'The number and order of strokes are essential in writing Chinese characters correctly.'),
        QuestionAnswerItem(13, false, 'What are the four Mandarin Chinese tones called?', '', 'The four Mandarin Chinese tones are called the first tone (阴平, yīn píng), the second tone (阳平, yáng píng), the third tone (上声, shǎng shēng), and the fourth tone (去声, qù shēng).'),
        QuestionAnswerItem(14, false, 'How do you say "thank you" in Mandarin?', '', 'To say "thank you" in Mandarin, you can use "谢谢" (xièxiè).'),
        QuestionAnswerItem(15, false, 'What is the importance of tones in Mandarin?', '', 'Tones in Mandarin are crucial because a change in tone can change the meaning of a word completely.'),
        QuestionAnswerItem(16, false, 'What is the Pinyin initial "zh" pronounced like?', '', 'The Pinyin initial "zh" is pronounced like the "j" sound in the English word "juice."'),
        QuestionAnswerItem(17, false, 'What are the basic Mandarin Chinese greetings?', '', 'Basic Mandarin Chinese greetings include "你好" (nǐ hǎo) for "hello" and "再见" (zàijiàn) for "goodbye."'),
        QuestionAnswerItem(18, false, 'What is a common Mandarin Chinese measure word for people?', '', 'A common measure word for people in Mandarin is "位" (wèi).'),
        QuestionAnswerItem(19, false, 'What is the Hanyu Shuiping Kaoshi (HSK) Level 1?', '', 'HSK Level 1 is the most basic level of the HSK exam and tests basic listening and reading skills.'),
        QuestionAnswerItem(20, false, 'How do you say "yes" and "no" in Mandarin?', '', 'In Mandarin, "yes" is "是" (shì), and "no" is "不是" (bù shì).'),
        QuestionAnswerItem(21, false, 'What is the importance of learning stroke order in writing characters?', '', 'Learning stroke order is important for writing Chinese characters neatly and legibly.'),
        QuestionAnswerItem(22, false, 'What is the Hanyu Shuiping Kaoshi (HSK) Level 6?', '', 'HSK Level 6 is the highest level of the HSK exam and tests advanced language skills.'),
        QuestionAnswerItem(23, false, 'How do you say "I love you" in Mandarin?', '', 'To say "I love you" in Mandarin, you can say "我爱你" (wǒ ài nǐ).'),
        QuestionAnswerItem(24, false, 'What is the meaning of "汉字" (hànzì) in Mandarin?', '', 'The term "汉字" (hànzì) means "Chinese characters" or "Hanzi."'),
        QuestionAnswerItem(25, false, 'What is the Pinyin initial "ch" pronounced like?', '', 'The Pinyin initial "ch" is pronounced like the "ch" sound in the English word "chocolate."'),
        QuestionAnswerItem(26, false, 'What is the role of the Mandarin tone marks in Pinyin?', '', 'Tone marks in Pinyin indicate the tone of a syllable and are essential for proper pronunciation.'),
        QuestionAnswerItem(27, false, 'What is the Pinyin initial "sh" pronounced like?', '', 'The Pinyin initial "sh" is pronounced like the "sh" sound in the English word "shoe."'),
        QuestionAnswerItem(28, false, 'What is a homophone in Mandarin?', '', 'A homophone in Mandarin is a word that sounds the same as another word but may have a different meaning and character.'),
        QuestionAnswerItem(29, false, 'What is the significance of "拼音" (pīnyīn) in Mandarin learning?', '', '"拼音" (pīnyīn) is Pinyin, the phonetic system used to teach pronunciation and writing in Mandarin.'),
        QuestionAnswerItem(30, false, 'What is the Pinyin initial "y" pronounced like?', '', 'The Pinyin initial "y" is pronounced like the "y" sound in the English word "yes."'),
        QuestionAnswerItem(31, false, 'What is the "ü" sound in Pinyin?', '', 'The "ü" sound in Pinyin is similar to the "u" sound in the French word "lune."'),
        QuestionAnswerItem(32, false, 'What is a common measure word for books in Mandarin?', '', 'A common measure word for books in Mandarin is "本" (běn).'),
        QuestionAnswerItem(33, false, 'What is the Mandarin phrase for "How are you?"', '', 'The Mandarin phrase for "How are you?" is "你好吗?" (nǐ hǎo ma?).'),
        QuestionAnswerItem(34, false, 'What is a common Mandarin greeting for the Lunar New Year?', '', 'A common greeting for the Lunar New Year is "新年快乐" (xīnnián kuàilè), which means "Happy New Year."'),
        QuestionAnswerItem(35, false, 'What are the four Mandarin tones used in Pinyin?', '', 'The four Mandarin tones used in Pinyin are marked by diacritic symbols, including the first tone (ā), the second tone (é), the third tone (ě), and the fourth tone (ò).'),
        QuestionAnswerItem(36, false, 'What is the difference between "普通话" (pǔtōnghuà) and "国语" (guóyǔ)?', '', 'Both terms refer to Mandarin, with "普通话" emphasizing "standard language" and "国语" emphasizing "national language."'),
        QuestionAnswerItem(37, false, 'How do you say "good morning" in Mandarin?', '', 'To say "good morning" in Mandarin, you can use "早上好" (zǎoshang hǎo).'),
        QuestionAnswerItem(38, false, 'What is a "Tongue Twister" in Mandarin?', '', 'A "Tongue Twister" in Mandarin is a challenging phrase or sentence used to practice pronunciation.'),
        QuestionAnswerItem(39, false, 'What is the significance of learning Chinese radicals?', '', 'Learning Chinese radicals helps understand the structure and meaning of characters.'),
        QuestionAnswerItem(40, false, 'What is the role of the Mandarin "bopomofo" system?', '', 'The "bopomofo" system is used for phonetic notation in Mandarin, especially in Taiwan.'),
        QuestionAnswerItem(41, false, 'What is the importance of tones in Mandarin singing?', '', 'Tones play a vital role in Mandarin singing, influencing melody and expression.'),
        QuestionAnswerItem(42, false, 'What is "白话" (báihuà) in Mandarin?', '', 'The term "白话" (báihuà) refers to "vernacular language" or spoken language in contrast to literary language.'),
        QuestionAnswerItem(43, false, 'How do you say "good night" in Mandarin?', '', 'To say "good night" in Mandarin, you can use "晚安" (wǎn\'ān).'),
        QuestionAnswerItem(44, false, 'What is "汉语" (hànyǔ) in Mandarin?', '', 'The term "汉语" (hànyǔ) means "Chinese language" or "Mandarin."'),
        QuestionAnswerItem(45, false, 'What is "语法" (yǔfǎ) in Mandarin?', '', 'The term "语法" (yǔfǎ) refers to "grammar" in Mandarin.'),
        QuestionAnswerItem(46, false, 'What is a "Mandarin immersion program"?', '', 'A Mandarin immersion program is an educational program where students learn various subjects in Mandarin.'),
        QuestionAnswerItem(47, false, 'How do you say "please" in Mandarin?', '', 'To say "please" in Mandarin, you can use "请" (qǐng).'),
        QuestionAnswerItem(48, false, 'What is "汉字书写" (hànzì shūxiě) in Mandarin?', '', 'The term "汉字书写" (hànzì shūxiě) means "Chinese character writing."'),
        QuestionAnswerItem(49, false, 'What is the role of "Hanyu Pinyin" in Mandarin teaching?', '', '"Hanyu Pinyin" is used to teach proper pronunciation and writing of Mandarin Chinese.'),
      ]));

      // Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(new FlashcardItem(0, 0, 0, 0, 'Language Learner', []));
      // Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(new FlashcardItem(0, 0, 0, 0, 'OOP Quiz Subject', []));
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('lib/assets/logo.png'),
              width: 200,
              height: 200,
            ),
            Text(
              appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'study on your terms',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          copyright,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
