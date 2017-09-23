/// @descr scr_chunk_get_layout_instances(index)
/// @param {any} index List of instances to return
/// @returns {string} instances_list_string


var instances_list_string = "";

switch (argument[0])
{
    case "cabin_1":
        instances_list_string += "2E0100000200000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000600100003932303130303030303630303030303030313030303030303043303030303030363936443631363736353546";
        instances_list_string += "37393733363336313643363530303030303030303030303030303030303030304638334630313030303030303037303030303030363436463646373235463639363430313030303030303034303030303030333033303330333230313030303030303031303030303030373830303030303030303030303030303030303030303434343030313030303030303043303030303030363936443631363736353546373837333633363136433635303030303030303030303030303030303030303030303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303038303030303030";
        instances_list_string += "36463632364135463634364636463732303130303030303030313030303030303739303030303030303030303030303030303030303034383430";
        break;
    
    case "tower_1":
        instances_list_string += "2E0100000200000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000600100003932303130303030303630303030303030313030303030303043303030303030363936443631363736353546";
        instances_list_string += "37393733363336313643363530303030303030303030303030303030303030304638334630313030303030303037303030303030363436463646373235463639363430313030303030303034303030303030333033303330333330313030303030303031303030303030373830303030303030303030303030303030303030303434343030313030303030303043303030303030363936443631363736353546373837333633363136433635303030303030303030303030303030303030303030303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303038303030303030";
        instances_list_string += "36463632364135463634364636463732303130303030303030313030303030303739303030303030303030303030303030303030303034433430";
        break;
    
    case "1":
        instances_list_string += "2E0100000500000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "3030303030303030303033303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333130313030303030303031303030303030373930303030303030303030303030303030303030303443343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303034433430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030";
        instances_list_string += "364636323641354637343732363536353546333330313030303030303031303030303030373930303030303030303030303030303030303030303438343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303035303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333230313030303030303031303030303030373930303030303030303030303030303030303030303530343001000000AE00";
        instances_list_string += "0000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030343034303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463333303130303030303030313030303030303739303030303030303030303030303030303030303035303430";
        break;
    
    case "5":
        instances_list_string += "2E0100000600000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "3030303030303030303034343430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333330313030303030303031303030303030373930303030303030303030303030303030303030303530343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303034433430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030";
        instances_list_string += "364636323641354637343732363536353546333330313030303030303031303030303030373930303030303030303030303030303030303030303532343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303035303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333330313030303030303031303030303030373930303030303030303030303030303030303030303434343001000000AE00";
        instances_list_string += "000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303033303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333330313030303030303031303030303030373930303030303030303030303030303030303030303438343001000000AE000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030333834303031303030303030";
        instances_list_string += "304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463332303130303030303030313030303030303739303030303030303030303030303030303030303034303430";
        break;
    
    case "3":
        instances_list_string += "2E0100000200000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "30303030303030303030333834303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463333303130303030303030313030303030303739303030303030303030303030303030303030303035303430";
        break;
    
    case "4":
        instances_list_string += "2E0100000400000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "3030303030303030303034433430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333130313030303030303031303030303030373930303030303030303030303030303030303030303430343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303033383430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030";
        instances_list_string += "364636323641354637343732363536353546333130313030303030303031303030303030373930303030303030303030303030303030303030303434343001000000AE000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030353034303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463332303130303030303030313030303030303739303030303030303030303030303030303030303035303430";
        break;
    
    case "0":
        instances_list_string += "2E0100000500000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "3030303030303030303035323430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333130313030303030303031303030303030373930303030303030303030303030303030303030303430343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303034303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030";
        instances_list_string += "364636323641354637343732363536353546333230313030303030303031303030303030373930303030303030303030303030303030303030303430343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303034433430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333230313030303030303031303030303030373930303030303030303030303030303030303030303530343001000000AE00";
        instances_list_string += "0000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030333034303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463333303130303030303030313030303030303739303030303030303030303030303030303030303035323430";
        break;
    
    case "2":
        instances_list_string += "2E0100000400000001000000B6000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030303030303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030453030303030303646363236413546363336383735364536423546373336393741363530313030303030303031303030303030373930303030303030303030303030303030303030303030303001000000AE0000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030";
        instances_list_string += "3030303030303030303034303430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030364636323641354637343732363536353546333130313030303030303031303030303030373930303030303030303030303030303030303030303434343001000000AE00000039323031303030303033303030303030303130303030303030313030303030303738303030303030303030303030303030303030303034343430303130303030303030423030303030303646363236413635363337343546364536313644363530313030303030303041303030303030";
        instances_list_string += "364636323641354637343732363536353546333230313030303030303031303030303030373930303030303030303030303030303030303030303530343001000000AE000000393230313030303030333030303030303031303030303030303130303030303037383030303030303030303030303030303030303030353034303031303030303030304230303030303036463632364136353633373435463645363136443635303130303030303030413030303030303646363236413546373437323635363535463332303130303030303030313030303030303739303030303030303030303030303030303030303034303430";
        break;
    
    case "tower_2":
        instances_list_string += "2E0100000100000001000000B60000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030303030303030303030303030303030313030303030303042303030303030364636323641363536333734354636453631364436353031303030303030304530303030303036463632364135463633363837353645364235463733363937413635303130303030303030313030303030303739303030303030303030303030303030303030303030303030";
        break;
    
    case "default":
    default:
        instances_list_string += "2E0100000100000001000000B60000003932303130303030303330303030303030313030303030303031303030303030373830303030303030303030303030303030303030303030303030313030303030303042303030303030364636323641363536333734354636453631364436353031303030303030304530303030303036463632364135463633363837353645364235463733363937413635303130303030303030313030303030303739303030303030303030303030303030303030303030303030";
    
}

return instances_list_string;
