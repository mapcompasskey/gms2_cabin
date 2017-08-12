/// @descr scr_output(var1, var2, var3, ...)

var i;
var str = "";
for (i = 0; i < argument_count; i++)
{
    if (i > 0)
    {
        str += ", ";
    }
    str += string(argument[i]);
}

show_debug_message(str);
