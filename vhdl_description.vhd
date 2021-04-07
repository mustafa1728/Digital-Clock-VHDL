
ENTITY TimeSet Is
PORT(
        masterClk : IN bit;

        SIGNAL digitPlace : bit_vector(3 down to 0);
        SIGNAL incMode: bit;
        SIGNAL dispMode: bit;
        dispModeChange : IN bit;
        incModeChange : IN bit;
        incButton : IN bit;
        decButton : IN bit;
        digitChange : IN bit;

        minutes, seconds, hours : OUT bit_vector(5 down to 0);
        dispMode: OUT bit;
    );
END TimeSet;

ARCHITECTURE TimeSetter of TimeSet IS 
SIGNAL minutes, seconds, hours : bit_vector(5 down to 0);
SIGNAL count : bit_vector(25 down to 0);
SIGNAL countFast : bit_vector(23 down to 0);
SIGNAL clk : bit;
SIGNAL clkFast : bit;

BEGIN 
    
    --clk of frequency 1HZ from 100MHz master
    PROCESS(masterClk)
    BEGIN
        IF(masterClk'event and masterClk='1') THEN
            count <=count + '00000000000000000000000001';
            IF(count = '10111110101111000010000000') THEN
                clk <= not clk;
                count <= '00000000000000000000000001';
            END IF;
        END IF;
    END PROCESS;


    --clkFast of frequency 5HZ from 100MHz master
    PROCESS(masterClk)
    BEGIN
        IF(masterClk'event and masterClk='1') THEN
            count <=count + '000000000000000000000001';
            IF(count = '100110001001011010000000') THEN
                clkFast <= not clkFast;
                count <= '000000000000000000000001';
            END IF;
        END IF;
    END PROCESS;

    PROCESS (digitChange)
    BEGIN
        IF(digitChange = 1) THEN
            IF (digitPlace = '1000') THEN
                digitPlace <= '0100'
            ELSE IF (digitPlace = '0100') THEN
                digitPlace <= '0010'
            ELSE IF (digitPlace = '0010') THEN
                digitPlace <= '0001'
            ELSE IF (digitPlace = '0001') THEN
                digitPlace <= '1000'
            END IF
        END IF 
    END PROCESS

    PROCESS (incModeChange)
    BEGIN
        incMode <= not incMode;
    END PROCESS
    
    PROCESS (dispModeChange)
    BEGIN
        dispMode <= not dispMode;
    END PROCESS

    PROCESS(clk, incButton, decButton)
    BEGIN
        IF (incMode = '0') THEN 
            IF (dispMode = '0') THEN
            -- HH MM mode
                IF(clk'event and clk='1') THEN
                    IF (digitPlace = '1000') THEN
                        IF (incButton = '1') THEN 
                            hours <= hours + '001010'
                        ELSE IF (decButton = '1')) Then 
                            hours <= hours - '001010'
                        END IF
                    ELSE IF (digitPlace = '0100') THEN
                        IF (incButton = '1') THEN 
                            hours <= hours + '000001'
                        ELSE IF (decButton = '1')) Then 
                            hours <= hours - '000001'
                        END IF
                    ELSE IF (digitPlace = '0010') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '001010'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '001010'
                        END IF
                    ELSE IF (digitPlace = '0001') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '000001'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '000001'
                        END IF
                    END IF
                END IF


            ELSE
            -- MM SS mode
                IF(clk'event and clk='1') THEN
                    IF (digitPlace = '1000') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '001010'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '001010'
                        END IF
                    ELSE IF (digitPlace = '0100') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '000001'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '000001'
                        END IF
                    ELSE IF (digitPlace = '0010') THEN
                        IF (incButton = '1') THEN 
                            seconds <= seconds + '001010'
                        ELSE IF (decButton = '1')) Then 
                            seconds <= seconds - '001010'
                        END IF
                    ELSE IF (digitPlace = '0001') THEN
                        IF (incButton = '1') THEN 
                            seconds <= seconds + '000001'
                        ELSE IF (decButton = '1')) Then 
                            seconds <= seconds - '000001'
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END PROCESS


    PROCESS(clkFast, incButton, decButton)
        IF (incMode = '1') THEN 
            IF (dispMode = '0') THEN
            -- HH MM mode
                IF(clkFast'event and clkFast='1') THEN
                    IF (digitPlace = '1000') THEN
                        IF (incButton = '1') THEN 
                            hours <= hours + '001010'
                        ELSE IF (decButton = '1')) Then 
                            hours <= hours - '001010'
                        END IF
                    ELSE IF (digitPlace = '0100') THEN
                        IF (incButton = '1') THEN 
                            hours <= hours + '000001'
                        ELSE IF (decButton = '1')) Then 
                            hours <= hours - '000001'
                        END IF
                    ELSE IF (digitPlace = '0010') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '001010'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '001010'
                        END IF
                    ELSE IF (digitPlace = '0001') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '000001'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '000001'
                        END IF
                    END IF
                END IF


            ELSE
            -- MM SS mode
                IF(clkFast'event and clkFast='1') THEN
                    IF (digitPlace = '1000') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '001010'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '001010'
                        END IF
                    ELSE IF (digitPlace = '0100') THEN
                        IF (incButton = '1') THEN 
                            minutes <= minutes + '000001'
                        ELSE IF (decButton = '1')) Then 
                            minutes <= minutes - '000001'
                        END IF
                    ELSE IF (digitPlace = '0010') THEN
                        IF (incButton = '1') THEN 
                            seconds <= seconds + '001010'
                        ELSE IF (decButton = '1')) Then 
                            seconds <= seconds - '001010'
                        END IF
                    ELSE IF (digitPlace = '0001') THEN
                        IF (incButton = '1') THEN 
                            seconds <= seconds + '000001'
                        ELSE IF (decButton = '1')) Then 
                            seconds <= seconds - '000001'
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END PROCESS

END TimeSetter;






























ENTITY TimeKeep IS 
PORT (  
        masterClk : IN bit;
        minutes, seconds, hours : OUT bit_vector(5 down to 0);
    );

END TimeKeep;


ARCHITECTURE TimeKeeper of TimeKeep IS 
SIGNAL minutes, seconds, hours : bit_vector(5 down to 0);
SIGNAL count : bit_vector(25 down to 0);
SIGNAL clk : bit;
BEGIN 
    --clk of frequency 1HZ from 100MHz masterClk
    PROCESS(masterClk)
    BEGIN
        IF(masterClk'event and masterClk='1') THEN
            count <=count + '00000000000000000000000001';
            IF(count = '10111110101111000010000000') THEN
                clk <= not clk;
                count <= '00000000000000000000000001';
            END IF;
        END IF;
    END PROCESS;

    PROCESS(clk)  
    BEGIN
        IF(clk'event and clk='1') THEN
            seconds <= seconds + '000001';
            IF(seconds = '111011') THEN
                seconds <= "000000";
                minutes <= minutes + '000001';
                IF(min = '111011') THEN
                    hour <= hour + '00001';
                    minutes <= "000000";
                    IF(hour = '010111') THEN
                        hour <= "000000";
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END TimeKeeper;

























ENTITY display IS
PORT(
        masterClk : IN bit;
        dispMode : IN bit;
        minutes, seconds, hours : IN bit_vector(5 down to 0);

        7Seg0, 7Seg1, 7Seg2, 7Seg3 :  OUT bit_vector (6 downto 0));
        dot0, dot1, dot2, dot3: OUT bit;
    );
END display

ARCHITECTURE displayer of display IS 
SIGNAL digit0, digit1, digit2, digit3: bit_vector (3 downto 0));
SIGNAL 7Seg0, 7Seg1, 7Seg2, 7Seg3 : bit_vector (6 downto 0));
SIGNAL dot0, dot1, dot2, dot3: bit: 0, 0, 0, 1;
SIGNAL refreshClk: bit;
SIGNAL clk: bit;
SIGNAL countRefresh : bit_vector(15 down to 0);
SIGNAL count : bit_vector(24 down to 0);
BEGIN 
    
    --refreshClk of frequency 1000HZ from 100MHz master (giving rise to a 1ms refresh rate)
    PROCESS(masterClk)
    BEGIN
        IF(masterClk'event and masterClk='1') THEN
            countRefresh <=countRefresh + '0000000000000001';
            IF(countRefresh = '1100001101010000') THEN
                refreshClk <= not refreshClk;
                countRefresh <= '0000000000000001';
            END IF;
        END IF;
    END PROCESS;

    --clk of frequency 2HZ from 100MHz master
    PROCESS(masterClk)
    BEGIN
        IF(masterClk'event and masterClk='1') THEN
            count <=count + '0000000000000000000000001';
            IF(count = '1011111010111100001000000') THEN
                clk <= not clk;
                count <= '0000000000000000000000001';
            END IF;
        END IF;
    END PROCESS;


    PROCESS(refreshClk, dispMode)
    BEGIN
        IF(refreshClk'event and refreshClk='1') THEN
            IF dispMode = '0' THEN
            -- HH MM mode
                IF (hours > '010100') THEN 
                    digit0 <= '0010'
                    digit1 <= hours - '010100'
                ELSE IF (hours > '001010') THEN 
                    digit0 <= '0001'
                    digit1 <= hours - '001010'
                ELSE
                    digit0 <= '0000'
                    digit1 <= hours
                END IF

                IF (minutes > '110010') THEN 
                    digit2 <= '0101'
                    digit3 <= minutes - '110010'
                ELSE IF (minutes > '101000') THEN 
                    digit2 <= '0100'
                    digit3 <= minutes - '101000'
                ELSE IF (minutes > '011110') THEN 
                    digit2 <= '0011'
                    digit3 <= minutes - '011110'
                ELSE IF (minutes > '010100') THEN 
                    digit2 <= '0010'
                    digit3 <= minutes - '010100'
                ELSE IF (minutes > '001010') THEN 
                    digit2 <= '0001'
                    digit3 <= minutes - '001010'
                ELSE
                    digit2 <= '0001'
                    digit3 <= minutes
                END IF

            ELSE
            -- MM SS mode
                IF (minutes > '110010') THEN 
                    digit0 <= '0101'
                    digit1 <= minutes - '110010'
                ELSE IF (minutes > '101000') THEN 
                    digit0 <= '0100'
                    digit1 <= minutes - '101000'
                ELSE IF (minutes > '011110') THEN 
                    digit0 <= '0011'
                    digit1 <= minutes - '011110'
                ELSE IF (minutes > '010100') THEN 
                    digit0 <= '0010'
                    digit1 <= minutes - '010100'
                ELSE IF (minutes > '001010') THEN 
                    digit0 <= '0001'
                    digit1 <= minutes - '001010'
                ELSE
                    digit0 <= '0001'
                    digit1 <= minutes
                END IF

                IF (seconds > '110010') THEN 
                    digit2 <= '0101'
                    digit3 <= seconds - '110010'
                ELSE IF (seconds > '101000') THEN 
                    digit2 <= '0100'
                    digit3 <= seconds - '101000'
                ELSE IF (seconds > '011110') THEN 
                    digit2 <= '0011'
                    digit3 <= seconds - '011110'
                ELSE IF (seconds > '010100') THEN 
                    digit2 <= '0010'
                    digit3 <= seconds - '010100'
                ELSE IF (seconds > '001010') THEN 
                    digit2 <= '0001'
                    digit3 <= seconds - '001010'
                ELSE
                    digit2 <= '0001'
                    digit3 <= seconds
                END IF
            END IF 
        END IF
    END PROCESS

    PROCESS(refreshClk)
    BEGIN
        IF(refreshClk'event and refreshClk='1') THEN
            CASE digit0 IS
                when "0000" => 7Seg0 <= "1111110"; -- "0"     
                when "0001" => 7Seg0 <= "0110000"; -- "1" 
                when "0010" => 7Seg0 <= "1101101"; -- "2" 
                when "0011" => 7Seg0 <= "1111001"; -- "3" 
                when "0100" => 7Seg0 <= "0110011"; -- "4" 
                when "0101" => 7Seg0 <= "1011011"; -- "5" 
                when "0110" => 7Seg0 <= "1011111"; -- "6" 
                when "0111" => 7Seg0 <= "1110000"; -- "7" 
                when "1000" => 7Seg0 <= "1111111"; -- "8"     
                when "1001" => 7Seg0 <= "1111011"; -- "9" 
                when others => 7Seg0 <= "0000000";
            CASE digit1 IS
                when "0000" => 7Seg1 <= "1111110"; -- "0"     
                when "0001" => 7Seg1 <= "0110000"; -- "1" 
                when "0010" => 7Seg1 <= "1101101"; -- "2" 
                when "0011" => 7Seg1 <= "1111001"; -- "3" 
                when "0100" => 7Seg1 <= "0110011"; -- "4" 
                when "0101" => 7Seg1 <= "1011011"; -- "5" 
                when "0110" => 7Seg1 <= "1011111"; -- "6" 
                when "0111" => 7Seg1 <= "1110000"; -- "7" 
                when "1000" => 7Seg1 <= "1111111"; -- "8"     
                when "1001" => 7Seg1 <= "1111011"; -- "9" 
                when others => 7Seg1 <= "0000000";
            CASE digit2 IS
                when "0000" => 7Seg2 <= "1111110"; -- "0"     
                when "0001" => 7Seg2 <= "0110000"; -- "1" 
                when "0010" => 7Seg2 <= "1101101"; -- "2" 
                when "0011" => 7Seg2 <= "1111001"; -- "3" 
                when "0100" => 7Seg2 <= "0110011"; -- "4" 
                when "0101" => 7Seg2 <= "1011011"; -- "5" 
                when "0110" => 7Seg2 <= "1011111"; -- "6" 
                when "0111" => 7Seg2 <= "1110000"; -- "7" 
                when "1000" => 7Seg2 <= "1111111"; -- "8"     
                when "1001" => 7Seg2 <= "1111011"; -- "9" 
                when others => 7Seg2 <= "0000000";
            CASE digit3 IS
                when "0000" => 7Seg3 <= "1111110"; -- "0"     
                when "0001" => 7Seg3 <= "0110000"; -- "1" 
                when "0010" => 7Seg3 <= "1101101"; -- "2" 
                when "0011" => 7Seg3 <= "1111001"; -- "3" 
                when "0100" => 7Seg3 <= "0110011"; -- "4" 
                when "0101" => 7Seg3 <= "1011011"; -- "5" 
                when "0110" => 7Seg3 <= "1011111"; -- "6" 
                when "0111" => 7Seg3 <= "1110000"; -- "7" 
                when "1000" => 7Seg3 <= "1111111"; -- "8"     
                when "1001" => 7Seg3 <= "1111011"; -- "9" 
                when others => 7Seg3 <= "0000000";
        END IF

    END PROCESS

    PROCESS(clk, dispMode)
    BEGIN
        IF(clk'event and clk='1') THEN
            IF dispMode = '0' THEN
            -- HH MM mode
                dot3 <= not dot3
        END IF
    END PROCESS

END displayer




















ENTITY DigitalClock IS
PORT (  
        masterClk : IN bit;

        dispModeChange : IN bit;
        incModeChange : IN bit;
        incButton : IN bit;
        decButton : IN bit;
        digitChange : IN bit;
        
        7Seg0, 7Seg1, 7Seg2, 7Seg3 :  OUT bit_vector (6 downto 0));
        dot0, dot1, dot2, dot3: OUT bit;
    );
END DigitalClock;


ARCHITECTURE DigitalClockArchitecture OF DigitalClock IS
BEGIN
SIGNAL hours : bit_vector(5 downto 0): '000000';
SIGNAL minutes : bit_vector(5 downto 0): '000000';
SIGNAL seconds : bit_vector(5 downto 0): '000000';

SIGNAL dispMode : bit : '0';
SIGNAL digitPlace : bit_vector(3 down to 0): '1000';
SIGNAL incMode: bit: '0';

    PROCESS (masterClk, dispModeChange, incModeChange, incButton, decButton, digitChange)
        IF (dispModeChange OR incModeChange OR incButton OR decButton OR digitChange = '1') THEN
            TimeInitialisation: ENTITY WORK.TimeSet(TimeSetter) 
                PORT MAP(
                            masterClk, 
                            dispModeChange,
                            incModeChange,
                            incButton,
                            decButton,
                            digitChange,

                            minutes, 
                            seconds, 
                            hours,
                            dispMode
                        );
                
        END IF
    END PEOCESS;  

    TimeUpdatePerSecond: ENTITY WORK.TimeKeep(TimeKeeper)
    PORT MAP(
                masterClk,

                minutes, 
                seconds, 
                hours,
            );


    DisplayTime: ENTITY WORK.display(displayer) 
    PORT MAP(
                masterClk,
                dispMode,
                minutes, 
                seconds, 
                hours,

                7Seg0, 7Seg1, 7Seg2, 7Seg3,
                dot0, dot1, dot2, dot3,
            );


               
END ARCHITECTURE DigitalClockArchitecture;


