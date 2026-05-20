public class Logic {
    public static void main(String[] args) {
        int a = 5;
        int b = 10;

        // Logical AND
        boolean andResult = (a > 0) && (b > 0);
        System.out.println("Logical AND: " + andResult); // true

        // Logical OR
        boolean orResult = (a > 0) || (b < 0);
        System.out.println("Logical OR: " + orResult); // true

        // Logical NOT
        boolean notResult = !(a > 0);
        System.out.println("Logical NOT: " + notResult); // false
    }


    
}
