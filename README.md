pray_time
Hello and welcome to the Flutter application!

Getting Started
This application is designed to help users manage their prayer time based on their location in Qatar. It is available in Arabic and English and supports adding additional languages in the future.

## The application includes the following features:

  - Reminders for each prayer with options to choose between an adhan sound notification or a simple ringtone.
  - The ability for the user to set the reminder time for each prayer, for example, the Fajr prayer alarm can be set to ring 15 minutes after the adhan entry.
  - The user can choose between an adhan sound notification or a simple ringtone for each prayer.
  - The ability for the user to enable or disable reminders for specific prayers. For example, the user can enable the reminder for Fajr prayer but disable the         reminder for Dhuhr prayer.
  - The ability to set the direction of the qibla.

## Defining the direction of the Qibla with flutter_qiblah


Flutter_qiblah is an open-source Flutter library that allows developers to easily integrate the direction of the qibla into their applications. This library uses the device's compass and GPS coordinates to calculate the direction of the qibla relative to the user's position.

To use Flutter_qiblah, simply add the library to your Flutter project and import it into your Dart file. You can then use the QiblahCompas class to retrieve the direction of the qibla. The library also provides pre-built widgets that can be customized to display the direction of the qibla to the user.

## Setting reminders for each prayer with LocalNotification

LocalNotification is an open-source library for Flutter that allows developers to easily add local notifications to their applications. In the context of a prayer application, this library can be used to set reminders for each prayer.

To use LocalNotification, simply add the library to your Flutter project and import it into your Dart file. You can then set a notification for each prayer using the schedule method of the FlutterLocalNotificationsPlugin class.

The schedule method takes several parameters, including the notification time, notification content, and unique notification ID. You can use the prayer time and reminder time set by the user to calculate the notification time.

When the prayer time is reached, the library sends a local notification to the user to remind them to pray. The user can also choose to enable or disable notifications for each prayer.

LocalNotification is a convenient and useful library for prayer applications. It allows users to set customized reminders for each prayer, which can help them maintain their religious practice and not miss an important prayer.

## schedule background tasks with WorkManager

To schedule background tasks for the prayer time application, we can use a package called WorkManager in Flutter. WorkManager allows us to schedule tasks to run in the background, even when the app is not in use. This is useful for scheduling reminders for prayer times, as the user may not have the app open when the prayer time is reached.

To use WorkManager, we need to add the package to our project and import it into our Dart file. We can then create a task and schedule it to run at a specific time using the WorkManager's scheduling methods. For example, we can schedule a task to send a notification to the user when the prayer time is reached.

Using WorkManager ensures that the reminders for prayer times are sent on time, even if the app is not open, and the user will not miss a prayer. It also allows the app to run more efficiently by running background tasks only when necessary, reducing battery drain and improving overall performance.

## Application Interfaces

![Prayer Time](https://user-images.githubusercontent.com/66421436/235308781-eb385055-ed3a-4cd1-8b99-46a804b3c03b.png)
