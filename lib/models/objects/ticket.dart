<<<<<<< HEAD:lib/models/objects/ticket.dart
class Ticket {
  final String uuid;
  final String user;
  final String event;
  final String session;
  final String ticket;
  final String referer;
  final String refererUser;
  final int price;
  final String ticketCode;
  final String cashlessNumber;
  final String accessedAt;
  final String checkinAt;
  final String lastEntryAt;
  final String lastExitAt;
  final int isRefundable;
  final String name;
  final String dni;
  final String birthdate;
  final String email;
  final String phone;
  final String gender;
  final String postalCode;
  final int age;
  final String question1Text;
  final String question1Answer;
  final String question2Text;
  final String question2Answer;
  final String question3Text;
  final String question3Answer;
  final String numeration;
  final String seatName;
  final String startDate;
  final String startDateVip;
  final String extra1Title;
  final String extra1Text;
  final String extra2Title;
  final String extra2Text;
  final String extra3Title;
  final String extra3Text;
  final String holderName;
  final String holderSurname;
  final String placeName;
  final String placeAddress;

  Ticket({
    required this.uuid,
    required this.user,
    required this.event,
    required this.session,
    required this.ticket,
    required this.referer,
    required this.refererUser,
    required this.price,
    required this.ticketCode,
    required this.cashlessNumber,
    required this.accessedAt,
    required this.checkinAt,
    required this.lastEntryAt,
    required this.lastExitAt,
    required this.isRefundable,
    required this.name,
    required this.dni,
    required this.birthdate,
    required this.email,
    required this.phone,
    required this.gender,
    required this.postalCode,
    required this.age,
    required this.question1Text,
    required this.question1Answer,
    required this.question2Text,
    required this.question2Answer,
    required this.question3Text,
    required this.question3Answer,
    required this.numeration,
    required this.seatName,
    required this.startDate,
    required this.startDateVip,
    required this.extra1Title,
    required this.extra1Text,
    required this.extra2Title,
    required this.extra2Text,
    required this.extra3Title,
    required this.extra3Text,
    required this.holderName,
    required this.holderSurname,
    required this.placeName,
    required this.placeAddress,
  });

  // Convierte un Ticket a un Map
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'user': user,
      'event': event,
      'session': session,
      'ticket': ticket,
      'referer': referer,
      'referer_user': refererUser,
      'price': price,
      'ticket_code': ticketCode,
      'cashless_number': cashlessNumber,
      'accessed_at': accessedAt,
      'checkin_at': checkinAt,
      'last_entry_at': lastEntryAt,
      'last_exit_at': lastExitAt,
      'is_refundable': isRefundable,
      'name': name,
      'dni': dni,
      'birthdate': birthdate,
      'email': email,
      'phone': phone,
      'gender': gender,
      'postal_code': postalCode,
      'age': age,
      'question1_text': question1Text,
      'question1_answer': question1Answer,
      'question2_text': question2Text,
      'question2_answer': question2Answer,
      'question3_text': question3Text,
      'question3_answer': question3Answer,
      'numeration': numeration,
      'seat_name': seatName,
      'start_date': startDate,
      'start_date_vip': startDateVip,
      'extra1_title': extra1Title,
      'extra1_text': extra1Text,
      'extra2_title': extra2Title,
      'extra2_text': extra2Text,
      'extra3_title': extra3Title,
      'extra3_text': extra3Text,
      'holder_name': holderName,
      'holder_surname': holderSurname,
      'place_name': placeName,
      'place_address': placeAddress,
    };
  }

  // Crea un Ticket a partir de un Map
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      uuid: map['uuid'],
      user: map['user'],
      event: map['event'],
      session: map['session'],
      ticket: map['ticket'],
      referer: map['referer'],
      refererUser: map['referer_user'],
      price: map['price'],
      ticketCode: map['ticket_code'],
      cashlessNumber: map['cashless_number'],
      accessedAt: map['accessed_at'],
      checkinAt: map['checkin_at'],
      lastEntryAt: map['last_entry_at'],
      lastExitAt: map['last_exit_at'],
      isRefundable: map['is_refundable'],
      name: map['name'],
      dni: map['dni'],
      birthdate: map['birthdate'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      postalCode: map['postal_code'],
      age: map['age'],
      question1Text: map['question1_text'],
      question1Answer: map['question1_answer'],
      question2Text: map['question2_text'],
      question2Answer: map['question2_answer'],
      question3Text: map['question3_text'],
      question3Answer: map['question3_answer'],
      numeration: map['numeration'],
      seatName: map['seat_name'],
      startDate: map['start_date'],
      startDateVip: map['start_date_vip'],
      extra1Title: map['extra1_title'],
      extra1Text: map['extra1_text'],
      extra2Title: map['extra2_title'],
      extra2Text: map['extra2_text'],
      extra3Title: map['extra3_title'],
      extra3Text: map['extra3_text'],
      holderName: map['holder_name'],
      holderSurname: map['holder_surname'],
      placeName: map['place_name'],
      placeAddress: map['place_address'],
    );
  }
=======
class Attendee {
  final String name;
  final String ticketType;
  final String ticketCode;
  final String status;

  Attendee({
    required this.name,
    required this.ticketType,
    required this.ticketCode,
    required this.status,
  });
>>>>>>> parent of dc54c47 (Cambios grandes !):lib/models/attendee.objeto.dart
}
