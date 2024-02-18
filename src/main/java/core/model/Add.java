package core.model;

import core.data.Animal;
import core.service.ConnectionData;
import core.service.Validate;
import java.sql.Date;
import java.sql.Time;
import java.util.Scanner;

public class Add extends Mode {

    public Add() {
        super("add", "добавить");
    }

    @Override
    public void execute(Scanner scanner) {
        System.out.print("Введите тип (прим:Cats) -> ");
        String type = scanner.next().strip().trim();

        System.out.print("Введите имя (прим:Barsik) -> ");
        String name = scanner.next().strip().trim();

        System.out.print("Введите дату (прим:yyyy-MM-dd) -> ");
        String birthdayString = scanner.next().strip().trim();
        Date birthday = Date.valueOf(birthdayString);

        String commands = String.valueOf(Validate.setCommands(scanner));

        Animal animal = Validate.getTypeAnimal(type, name, birthday, commands);
        new ConnectionData().setAnimalData(animal);
        System.out.println("-> добавлено успешно");
    }
}
