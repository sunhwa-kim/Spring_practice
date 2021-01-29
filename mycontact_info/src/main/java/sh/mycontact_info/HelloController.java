package sh.mycontact_info;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/hello")
    public String getHello(Model model) {
        model.addAttribute("data", "변경");
        return "hello";
    }

}
