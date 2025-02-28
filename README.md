# So Long Tester
## How to use the tester:
Make your project<br>
Simply clone the repository in your project folder<br>
```
git clone https://github.com/samtvn/so_long_tester.git
```
Launch the tester from your project directory<br>
```
./so_long_tester/test_broken.sh
```
One liner:<br>
```
make fclean && make && [ -d so_long_tester ] || git clone https://github.com/samtvn/so_long_tester.git && ./so_long_tester/test_broken.sh
```
## How to interpret the output
No Valgrind output means noleaks!<br>
If there are Valgrind outputs, then it is easy. There are leaks.<br>
You should check that it is the user's fault and not the minilibx.<br>
Normally, it should be the user's fault.<br>
<br>
```diff
- red does not mean it is KO.
```
 I just chose the output to be red. You should check each error output to ensure the user specifies the nature of the error as required by the subject.<br>
<br>
The three last tests require you to press ESC, the X button and then to test the game normally.<br>
You should certainly do the ESC and X tests again by yourself to check after taking collectibles too.