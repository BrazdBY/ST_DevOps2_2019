#Расшифровываем надпись
#Код код буквы символа +2, также можно решить задачу через составления массива хешзначений, где код - это буква из шифра, а значение - буква сдвинутая на две позиции, тогда не надо будет писать второе условие про буквы Z и Y.

#[string]$sign = "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq () gq pcamkkclbcb. lmu ynnjw ml rfc spj"
[string]$sign = "http://www.pythonchallenge.com/pc/def/map.html"

function charToNewChar ([string]$letter) #функция возвращающая корректный символ
{
     if (([int][char]$letter -ge 97) -and ([int][char]$letter -le 119)) 
     {
       [int]$codLetter = ([int][char]$letter)
        return [char]($codLetter + 2) 
     }
     else    
     {
        if ($letter -eq "y" -or $letter -eq "z") 
        {
            return  [char]([int][char]$letter - 24)
        }
        

     }

     return $letter
     
}

charToNewChar('z')
charToNewChar('y')

function Translit ([string]$inString) #функция пробегающая по строке и формирующая новую корректную строку.
{
   
    $CorrectText = ""
    foreach ($CHR in $inCHR = $inString.ToCharArray())
        {
                   
             $CorrectText += charToNewChar($CHR) 
        }
    return $CorrectText
}

translit $sign
