package core.service;

import core.data.*;

import java.sql.Date;
import java.util.Scanner;

public class Validate {
    public static Animal getTypeAnimal(String type, String name, Date birthday, String commands) {
        switch (type.toUpperCase()) {
            case "CATS" -> {
                return new Cat(name, birthday, commands);
            }
            case "DOGS" -> {
                return new Dog(name, birthday, commands);
            }
            case "HAMSTERS" -> {
                return new Hamster(name, birthday, commands);
            }
            case "HORSES" -> {
                return new Horse(name, birthday, commands);
            }
            case "DONKEYS" -> {
                return new Donkey(name, birthday, commands);
            }
            case "CAMELS" -> {
                return new Camel(name, birthday, commands);
            }
            default ->
                throw new IllegalStateException("Нет такого животного");
        }
    }

    public static StringBuilder setCommands(Scanner scanner) {
        StringBuilder commands = new StringBuilder();

        while (true) {
            System.out.print("Введите комманду (прим:Jump) -> ");
            String command = scanner.next().strip().trim();
            commands.append(command);

            System.out.print("Добавить еще команды Y/N ->");
            String choice = scanner.next().toLowerCase().trim().strip();
            if (!choice.equals("y")) {
                break;
            }
            commands.append(", ");
        }
        return commands;
    }
}
