class TimeCalculator {
  ///takes a [DateTime] and returns it in a [dd mon yyyy hh:mm] format.
  static String dateFormatter({DateTime givenTime}) {
    List<String> dateAndTime = givenTime.toString().split(" ");
    List<String> date = dateAndTime.first.split("-");
    List<String> time = dateAndTime.last.split(":");

    switch (date[1]) {
      case "01":
        date[1] = "Jan";
        break;
      case "02":
        date[1] = "Feb";
        break;
      case "03":
        date[1] = "Mar";
        break;
      case "04":
        date[1] = "Apr";
        break;
      case "05":
        date[1] = "May";
        break;
      case "06":
        date[1] = "Jun";
        break;
      case "07":
        date[1] = "Jul";
        break;
      case "08":
        date[1] = "Aug";
        break;
      case "09":
        date[1] = "Sept";
        break;
      case "10":
        date[1] = "Oct";
        break;
      case "11":
        date[1] = "Nov";
        break;
      case "12":
        date[1] = "Dec";
        break;
    }

    return "${date.reversed.join(" ")} at ${time.getRange(0, 2).join(":")}";
  }

  /// takes a [DateTime] and returns it's difference from the current [DateTime].
  static String getTimeDifference(DateTime givenTime) {
    final int seconds = DateTime.now().difference(givenTime).inSeconds;

    int minutes = 0;
    int hours = 0;
    int days = 0;
    int weeks = 0;
    int months = 0;
    int years = 0;

    int minuteMark = 60;
    int hourMark = minuteMark * 60;
    int dayMark = hourMark * 24;
    int weekMark = dayMark * 7;
    int monthMark = dayMark * 31;
    int yearMark = dayMark * 365;

    String timeDifference;

    int remainingSeconds() {
      return seconds % minuteMark;
    }

    int remainingMinutes() {
      return (seconds % hourMark) ~/ minuteMark;
    }

    int remainingHours() {
      return (seconds % dayMark) ~/ hourMark;
    }

    int remainingDays() {
      return (seconds % weekMark) ~/ dayMark;
    }

    int remainingWeeks() {
      return (seconds % monthMark) ~/ weekMark;
    }

    int remainingMonths() {
      return (seconds % yearMark) ~/ monthMark;
    }

    if (seconds < 60) {
      timeDifference = "$seconds seconds ago";
    } else {
      minutes = seconds ~/ 60;
      if (minutes < 60) {
        timeDifference =
            "$minutes ${minutes > 1 ? "minutes" : "minute"} ${remainingSeconds()} seconds ago";
      } else {
        hours = minutes ~/ 60;
        if (hours < 24) {
          timeDifference =
              "$hours ${hours > 1 ? "hours" : "hour"} ${remainingMinutes()} ${remainingMinutes() > 1 ? "minutes" : "minute"} ago";
        } else {
          days = hours ~/ 24;
          if (days < 7) {
            timeDifference =
                "$days ${days > 1 ? "days" : "day"} ${remainingHours()} ${remainingHours() > 1 ? "hours" : "hour"} ago";
          } else {
            weeks = days ~/ 7;
            if (weeks < 4 && days < 31) {
              timeDifference =
                  "$weeks ${weeks > 1 ? "weeks" : "week"} ${remainingDays() > 0 ? "${remainingDays()} " : ""}${remainingDays() > 0 ? remainingDays() > 1 ? "days " : "day " : ""}ago";
            } else {
              months = days ~/ 31;
              if (months < 12 && days < 365) {
                timeDifference =
                    "$months ${months > 1 ? "months" : "month"} ${remainingWeeks() > 0 ? "${remainingWeeks()} " : ""}${remainingWeeks() > 0 ? remainingWeeks() > 1 ? "weeks " : "week " : ""}ago";
              } else {
                years = days ~/ 365;
                timeDifference =
                    "$years ${years > 1 ? "years" : "year"} ${remainingMonths() > 0 ? "${remainingMonths()} " : ""}${remainingMonths() > 0 ? remainingMonths() > 1 ? "months " : "month " : ""}ago";
              }
            }
          }
        }
      }
    }

    return timeDifference;
  }
}
