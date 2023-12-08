classdef Final_App_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        DIONYSUSPROJECTTexasHoldemProbabilityCalculatorLabel  matlab.ui.control.Label
        UITable                   matlab.ui.control.Table
        Card2ValueDropDown        matlab.ui.control.DropDown
        Card2ValueDropDownLabel   matlab.ui.control.Label
        Card1ValueDropDown        matlab.ui.control.DropDown
        Card1ValueDropDownLabel   matlab.ui.control.Label
        Card2SuitDropDown         matlab.ui.control.DropDown
        Card2SuitDropDownLabel    matlab.ui.control.Label
        Card1SuitDropDown_2       matlab.ui.control.DropDown
        Card1SuitDropDown_2Label  matlab.ui.control.Label
        ClicktoComputeButton      matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ClicktoComputeButton
        function buttonpushed(app, event)
            function c = myAdd(a,b)
                c=a+b
                
                if c>14
                    c=c-13
                elseif c<2
                    c=c+13
                end
                
            end
            card1value=app.Card1ValueDropDown.Value
            card2value=app.Card2ValueDropDown.Value
            card1suit=app.Card1SuitDropDown_2.Value
            card2suit=app.Card2SuitDropDown.Value
            

            



            test=(strcmp(card1suit,card2suit))
            test2=(strcmp(card1value,card2value))
            test3=test&&test2
            

                if(strcmp(card1value,'Choose')|strcmp(card2value,'Choose')|strcmp(card1suit,'Choose')|strcmp(card2suit,'Choose'))
                    f = errordlg('Invalid Choice','Choose a card');

                elseif test3==true 
                        f = errordlg('Invalid Choice','Choose 2 Different Cards');
                    
                else
                    
                    royalprob=0;
                    originalstraightfluprob=0;
                    straightfluprob=0;
                    straightprob=0;
                    fourprob=0;
                    threeprob=0;
                    fullhouseprob=0;
                    flushprob=0;
                    b = nchoosek(50,3);

                     if strcmp(card1value,'J')
                        card1value=11
    
                            elseif strcmp(card1value,'Q')
                                 card1value=12
        
                            elseif strcmp(card1value,'K')
                                 card1value=13
        
                            elseif strcmp(card1value,'A')
                                 card1value=14
        
                            elseif strcmp(card2value,'J')
                                card2value=11
        
                            elseif strcmp(card2value,'Q')
                                 card2value=12
        
                            elseif strcmp(card2value,'K')
                                 card2value=13
        
                            elseif strcmp(card2value,'A')
                                 card2value=14
                            
                     
                         
                     end
                     if ischar(card1value)
                        card1value=str2num(card1value)
                     end
                     if ischar(card2value)
                     card2value=str2num(card2value)
                     end
test4=myAdd(card1value,1)
test5= card2value==test4
test6 = card2value

                        %Royal Flush%
                        if (strcmp(card1suit,card2suit)) && card1value>=10 && card2value>=10
                           
                            royalprob= 1/b;
                            
                        end

                        

                        if strcmp(card1suit,card2suit)&&((myAdd(card1value,1))==card2value||(myAdd(card1value,-1))==card2value)

                            straightfluprob=(4/b)
                            originalstraightfluprob=straightfluprob

                            if(card1value>=10)
                                straightfluprob=straightfluprob-(1/b)
                            end

                        elseif strcmp(card1suit,card2suit)&&((myAdd(card1value,2))==card2value||(myAdd(card1value,-2))==card2value)
                            
                            straightfluprob=(3/b)
                            originalstraightfluprob=straightfluprob

                            if(card1value>=10)
                                straightfluprob=straightfluprob-(1/b)
                            end

                        elseif strcmp(card1suit,card2suit)&&((myAdd(card1value,3))==card2value||(myAdd(card1value,-3))==card2value)

                            straightfluprob=(2/b)
                            originalstraightfluprob=straightfluprob

                            if(card1value>=10)
                                straightfluprob=straightfluprob-(1/b)
                            end

                        elseif strcmp(card1suit,card2suit)&&((myAdd(card1value,4))==card2value||(myAdd(card1value,-4))==card2value)

                            straightfluprob=(1/b)
                            originalstraightfluprob=straightfluprob

                             if(card1value>=10)
                                straightfluprob=straightfluprob-(1/b)
                             end

                        end

                        %4 and 3 of a Kind, and Full House%
                        if card1value==card2value
                            fourprob=1/b
                            
                            threeprob=(2*48*47)/b

                            fullcom1 = nchoosek(2,1);
                            fullcom2 = nchoosek(4,2);
                            fullcom3 = nchoosek(4,3);

                            fullcomupleft=fullcom1*fullcom2*12
                            fullcomupright=fullcom3*12

                            fullcomleft=fullcomupleft/b
                            fullcomright=fullcomupright/b
                            
                            fullhouseprob=fullcomleft+fullcomright
                         
                        else
                            fourprob=2/b

                            threecom = nchoosek(3,2);
                            threevar=(2*threecom*44)
                            threeprob=threevar/b

                            fullcom1 = nchoosek(3,2);
                            fullcom2 = nchoosek(3,1);
                            fullvar=fullcom1*fullcom2*2
                            fullhouseprob=fullvar/b

                        end
                        
                         %Flush%
                         if strcmp(card1suit,card2suit)
                             flushcomb=nchoosek(11,3);
                            flushprob=flushcomb/b
                            %change
                                if strcmp(card1suit,card2suit)&&(strcmp(card1suit,card2suit)&&((myAdd(card1value,1))==card2value||(myAdd(card1value,-1))==card2value)||strcmp(card1suit,card2suit)&&((myAdd(card1value,2))==card2value||(myAdd(card1value,-2))==card2value)||strcmp(card1suit,card2suit)&&((myAdd(card1value,3))==card2value||(myAdd(card1value,-3))==card2value)||strcmp(card1suit,card2suit)&&((myAdd(card1value,4))==card2value||(myAdd(card1value,-4))==card2value))
                                    flushprob=flushprob-originalstraightfluprob
                                end
                         end

                        %Straight%
                        if ((myAdd(card1value,1))==card2value||(myAdd(card1value,-1))==card2value)
                            straighttop=(4^3)*4
                            straightprob=straighttop/b

                            if strcmp(card1suit,card2suit)
                                straightprob=straightprob-originalstraightfluprob
                            end

                        elseif ((myAdd(card1value,2))==card2value||(myAdd(card1value,-2))==card2value)
                            straighttop=(4^3)*3
                            straightprob=straighttop/b

                            if strcmp(card1suit,card2suit)
                                straightprob=straightprob-originalstraightfluprob
                            end

                        elseif ((myAdd(card1value,3))==card2value||(myAdd(card1value,-3))==card2value)
                            straighttop=(4^3)*2
                            straightprob=straighttop/b

                            if strcmp(card1suit,card2suit)
                                straightprob=straightprob-originalstraightfluprob
                            end

                        elseif ((myAdd(card1value,4))==card2value||(myAdd(card1value,-4))==card2value)
                            straighttop=(4^3)*1
                            straightprob=straighttop/b

                            if strcmp(card1suit,card2suit)
                                straightprob=straightprob-originalstraightfluprob
                            end

                        end
                        percent = "%"
                        royalprob=strcat(num2str(royalprob*100,4),percent);
                        straightfluprob=strcat(num2str(straightfluprob*100,4),percent);
                        fourprob=strcat(num2str(fourprob*100,4),percent);
                        threeprob=strcat(num2str(threeprob*100),percent);
                        fullhouseprob=strcat(num2str(fullhouseprob*100,4),percent);
                        flushprob=strcat(num2str(flushprob*100,4),percent);
                        straightprob=strcat(num2str(straightprob*100,4),percent);
                        
                        t = app.UITable;
                        set(t,'Data',["Royal Straight Flush" royalprob; "Straight Flush" straightfluprob; "4 of a Kind" fourprob; "3 of a Kind" threeprob; "Full House" fullhouseprob; "Flush" flushprob; "Straight" straightprob ])
                        
                        set(t,'ColumnEditable',logical([0 0]))
                end
        end

        % Callback function
        function Changing(app, event)
            changingValue = event.Value;
            app.NumberofPlayersSpinner.Limits=[1 10];
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create ClicktoComputeButton
            app.ClicktoComputeButton = uibutton(app.UIFigure, 'push');
            app.ClicktoComputeButton.ButtonPushedFcn = createCallbackFcn(app, @buttonpushed, true);
            app.ClicktoComputeButton.Position = [30 194 106 23];
            app.ClicktoComputeButton.Text = 'Click to Compute';

            % Create Card1SuitDropDown_2Label
            app.Card1SuitDropDown_2Label = uilabel(app.UIFigure);
            app.Card1SuitDropDown_2Label.HorizontalAlignment = 'right';
            app.Card1SuitDropDown_2Label.Position = [35 282 65 22];
            app.Card1SuitDropDown_2Label.Text = 'Card 1 Suit';

            % Create Card1SuitDropDown_2
            app.Card1SuitDropDown_2 = uidropdown(app.UIFigure);
            app.Card1SuitDropDown_2.Items = {'Choose', 'Spades', 'Hearts', 'Clubs', 'Diamonds'};
            app.Card1SuitDropDown_2.Position = [115 282 100 22];
            app.Card1SuitDropDown_2.Value = 'Choose';

            % Create Card2SuitDropDownLabel
            app.Card2SuitDropDownLabel = uilabel(app.UIFigure);
            app.Card2SuitDropDownLabel.HorizontalAlignment = 'right';
            app.Card2SuitDropDownLabel.Position = [35 253 65 22];
            app.Card2SuitDropDownLabel.Text = 'Card 2 Suit';

            % Create Card2SuitDropDown
            app.Card2SuitDropDown = uidropdown(app.UIFigure);
            app.Card2SuitDropDown.Items = {'Choose', 'Spades', 'Hearts', 'Clubs', 'Diamonds'};
            app.Card2SuitDropDown.Placeholder = 'Choose';
            app.Card2SuitDropDown.Position = [115 253 100 22];
            app.Card2SuitDropDown.Value = 'Choose';

            % Create Card1ValueDropDownLabel
            app.Card1ValueDropDownLabel = uilabel(app.UIFigure);
            app.Card1ValueDropDownLabel.HorizontalAlignment = 'right';
            app.Card1ValueDropDownLabel.Position = [30 365 74 22];
            app.Card1ValueDropDownLabel.Text = 'Card 1 Value';

            % Create Card1ValueDropDown
            app.Card1ValueDropDown = uidropdown(app.UIFigure);
            app.Card1ValueDropDown.Items = {'Choose', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'};
            app.Card1ValueDropDown.Placeholder = 'Choose';
            app.Card1ValueDropDown.Position = [119 365 100 22];
            app.Card1ValueDropDown.Value = 'Choose';

            % Create Card2ValueDropDownLabel
            app.Card2ValueDropDownLabel = uilabel(app.UIFigure);
            app.Card2ValueDropDownLabel.HorizontalAlignment = 'right';
            app.Card2ValueDropDownLabel.Position = [30 332 74 22];
            app.Card2ValueDropDownLabel.Text = 'Card 2 Value';

            % Create Card2ValueDropDown
            app.Card2ValueDropDown = uidropdown(app.UIFigure);
            app.Card2ValueDropDown.Items = {'Choose', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'};
            app.Card2ValueDropDown.Position = [119 332 100 22];
            app.Card2ValueDropDown.Value = 'Choose';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Card Combination'; 'Probability (%)'};
            app.UITable.RowName = {};
            app.UITable.ColumnEditable = true;
            app.UITable.Position = [362 27 249 419];

            % Create DIONYSUSPROJECTTexasHoldemProbabilityCalculatorLabel
            app.DIONYSUSPROJECTTexasHoldemProbabilityCalculatorLabel = uilabel(app.UIFigure);
            app.DIONYSUSPROJECTTexasHoldemProbabilityCalculatorLabel.Position = [35 416 201 30];
            app.DIONYSUSPROJECTTexasHoldemProbabilityCalculatorLabel.Text = {'DIONYSUS PROJECT'; 'Texas Hold''em Probability Calculator'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Final_App_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end