abstract class EventAPI {}

class EventFindRecepies extends EventAPI {
  String menuName;
  EventFindRecepies(this.menuName);
}
