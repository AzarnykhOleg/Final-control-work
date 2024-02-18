package core.model;

import core.service.ConnectionData;

import java.util.List;
import java.util.Scanner;

public class Count extends Mode {

    public Count() {
        super("count", "колличество");
    }

    @Override
    public void execute(Scanner scanner) {
        List<Integer> counter = new ConnectionData().countAnimalData();
        System.out.format("Колличество: домашних животных - %d, вьючных животных - %d\n", counter.get(0), counter.get(1));
    }
}
