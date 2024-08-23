#include<iostream>
#include "traverse.h"

std::string Traverse(Tree *head)
{
    string s = "";
    if (head != NULL)
    {
        if (head->dtype == D_SECTION)
        {
            s += "# ";
            s = s + string((head->child)->data) + "\n";
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_SUB_SECTION)
        {
            s += "## ";
            s = s + string((head->child)->data) + "\n";
            s = s + Traverse(head->next);
        }
        if (head->dtype == D_SUBSUB_SECTION)
        {
            s += "### ";
            s = s + string((head->child)->data) + "\n";
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_ITALIC)
        {
            s += "*";
            s = s + string((head->child)->data) + "*\n";
            s += Traverse(head->next);
        }
        if (head->dtype == D_BOLD)
        {
            s += "***";
            s = s + string((head->child)->data) + "***\n";
            s += Traverse(head->next);
        }
        if (head->dtype == D_NEWLINE)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_HRULE)
        {
            s += "---\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_HREF)
        {
            s += "[";
            s += string((head->child)->data);
            s += "](";
            s += string(head->data);
            s += ")";
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_PAR)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_VERBATIM_START)
        {
            s += "\n```python";
            Tree *node = head->next;
            while (node->dtype != D_VERBATIM_END)
            {
                s = s + "\n" + string(node->data);
                node = node->next;
            }
            s += Traverse(node);
        }
        if (head->dtype == D_VERBATIM_END)
        {
            s += "\n\n```";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_ITEM_START)
        {
            Tree *node = head->next;
            string to_find = "item";
            while (node->dtype != D_ITEM_END)
            {
                string str = string(node->data);
                size_t pos = str.find(to_find);
                if (pos != string::npos)
                {
                    str.replace(pos, to_find.length(), "-");
                }
                s = s + "\n" + str;
                node = node->next;
            }
            s += Traverse(node);
        }
        if (head->dtype == D_ITEM_END)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_ENUM_START)
        {
            Tree *node = head->next;
            int i = 1;
            string to_find = "item";
            while (node->dtype != D_ENUM_END)
            {
                string str = string(node->data);
                size_t pos = str.find(to_find);
                if (pos != string::npos)
                {
                    str.replace(pos, to_find.length(), "");
                }
                s = s + "\n" + to_string(i) + ". " + str;
                i++;
                node = node->next;
            }
            s += Traverse(node);
        }
        if (head->dtype == D_ENUM_END)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_GRAPHIC)
        {
            s += "\n![IIT Delhi Campus]";
            s = s + "(" + string((head->child)->data) + ")";
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_INFORMATION)
        {
            s += string(head->data);
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_TABLE_START)
        {
            Tree *node = head->next;
            int counter = 0;
            int hlinecounter = 0;
            while (node->dtype != D_TABLE_END)
            {
                if (node->dtype == D_TABLE_NEWLINE)
                {
                    s += "\n";
                }
                if (node->dtype == D_TABLE_HLINE)
                {
                    if (hlinecounter == 1)
                    {
                        s += "|-------------|-------------|\n";
                    }
                    hlinecounter++;
                }
                if (node->dtype == D_TABLE_PART)
                {
                    s += "|";
                }
                if (node->dtype == D_INFORMATION)
                {
                    // s=s+to_string(counter);
                    if (counter % 2 == 0)
                    {
                        s += "|";
                        counter = counter + 1;
                        s = s + node->data;
                    }
                    else
                    {
                        s = s + node->data;
                        counter++;
                        s += "|";
                    }
                }
                node = node->next;
            }
            s += Traverse(node);
        }
        if (head->dtype == D_TABLE_END)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }

        return s;
    }
    return s;
}
