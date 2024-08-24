#include <iostream>
#include <fstream>
#include <gtest/gtest.h>
#include "ast_tree/ast.h"
#include "Traversor/traverse.h"

using namespace std;
extern int yyparse();
void yyerror(const char *s)
{
    printf("ERROR : %s \n", s);
}

Tree *root;
TEST(Latex_To_Markdown, section)
{
    const char* inputFilePath = "test_files/section.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "# THIS IS A SECTION\n");
}
TEST(Latex_To_Markdown, subsection)
{
    const char* inputFilePath = "test_files/subsection.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "## THIS IS A SUBSECTION\n");
}
TEST(Latex_To_Markdown, subsubsection)
{
    const char* inputFilePath = "test_files/subsubsection.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "## THIS IS A SUBSUBSECTION\n");
}
TEST(Latex_To_Markdown, italictext)
{
    const char* inputFilePath = "test_files/italictext.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "*Indian Institute of Technology Delhi (IIT Delhi) is one of the premier engineering institutes in India.*\n");
}
TEST(Latex_To_Markdown, boldtext)
{
    const char* inputFilePath = "test_files/boldtext.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "***Founded in 1961, IIT Delhi has grown into a world-class institution known for its cutting-edge research and academic excellence.***\n");
}
TEST(Latex_To_Markdown, hrule)
{
    const char* inputFilePath = "test_files/hrule.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "---\n");
}
TEST(Latex_To_Markdown, href)
{
    const char* inputFilePath = "test_files/href.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "[IIT Delhi Official Website](https://www.iitd.ac.in)");
}
TEST(Latex_To_Markdown, paragraph)
{
    const char* inputFilePath = "test_files/paragraph.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "IIT Delhi is located in Hauz Khas, New Delhi. It offers undergraduate, postgraduate, and doctoral programs in various fields of engineering and technology.\nThe institute is renowned for its rigorous academic programs and distinguished faculty.");
}
TEST(Latex_To_Markdown, verbatim)
{
    const char* inputFilePath = "test_files/verbatim.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "\n```python\ndef iit_delhi_info():\nprint(\"Welcome to IIT Delhi!\")\nprint(\"Explore the world-class research and academic programs.\")\n\n```");
}
TEST(Latex_To_Markdown, graphics)
{
    const char* inputFilePath = "test_files/graphics.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "\n![IIT Delhi Campus](images/technology.jpg)");
}
TEST(Latex_To_Markdown, itemize)
{
    const char* inputFilePath = "test_files/itemize.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "\n- Established: 1961\n- Location: Hauz Khas, New Delhi\n- Programs: B.Tech, M.Tech, Ph.D., and more\n");
}
TEST(Latex_To_Markdown, enumerate)
{
    const char* inputFilePath = "test_files/enumerate.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "\n1.  Campus Facilities\n2.  Research Opportunities\n3.  Alumni Achievements\n");
}
TEST(Latex_To_Markdown, table)
{
    const char* inputFilePath = "test_files/table.tex";
    FILE  *fptrin;
    extern FILE *yyin;

    fptrin = fopen(inputFilePath, "r");
    ASSERT_TRUE(fptrin!=NULL);

    yyin = fptrin;
    do
    {
        yyparse();
    } while (!feof(yyin));
    string result = "";
    if (root->dtype == PROGRAM_BEGINING)
    {
        result = Traverse(root->child);
    }
    // std::cout << result;
    EXPECT_EQ(result, "|Department | Programs |\n|-------------|-------------|\n|Computer Science | B.Tech, M.Tech, Ph.D. |\n|Electrical Engineering | B.Tech, M.Tech, Ph.D. |\n\n");
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}