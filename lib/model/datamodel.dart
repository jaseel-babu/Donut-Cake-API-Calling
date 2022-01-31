// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.items,
    });

    Items? items;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        items: Items.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "items": items!.toJson(),
    };
}

class Items {
    Items({
        this.item,
    });

    List<Item>? item;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": List<dynamic>.from(item!.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.id,
        this.type,
        this.name,
        this.ppu,
        this.batters,
        this.topping,
    });

    String? id;
    String? type;
    String? name;
    double? ppu;
    Batters? batters;
    List<Topping>? topping;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        ppu: json["ppu"].toDouble(),
        batters: Batters.fromJson(json["batters"]),
        topping: List<Topping>.from(json["topping"].map((x) => Topping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "ppu": ppu,
        "batters": batters!.toJson(),
        "topping": List<dynamic>.from(topping!.map((x) => x.toJson())),
    };
}

class Batters {
    Batters({
        this.batter,
    });

    List<Topping>? batter;

    factory Batters.fromJson(Map<String, dynamic> json) => Batters(
        batter: List<Topping>.from(json["batter"].map((x) => Topping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "batter": List<dynamic>.from(batter!.map((x) => x.toJson())),
    };
}

class Topping {
    Topping({
        this.id,
        this.type,
    });

    String? id;
    String? type;

    factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
    };
}
