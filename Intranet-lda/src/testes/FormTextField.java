/*
 * $Id: FormTextField.java,v 1.3 2005/05/09 11:52:35 blowagie Exp $
 * $Name:  $
 *
 * This code is part of the 'iText Tutorial'.
 * You can find the complete tutorial at the following address:
 * http://itextdocs.lowagie.com/tutorial/
 *
 * This code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * itext-questions@lists.sourceforge.net
 */

package testes;


import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.GrayColor;
import com.lowagie.text.pdf.PdfAnnotation;
import com.lowagie.text.pdf.PdfAppearance;
import com.lowagie.text.pdf.PdfBorderDictionary;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfFormField;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Generates an Acroform with a TextField
 * @author blowagie
 */
public class FormTextField {
    /**
     * Generates an Acroform with a TextField
     * @param args no arguments needed here
     */
    public static void main(String[] args) {
        
        System.out.println("Textfield");
        
        // step 1: creation of a document-object
        Document document = new Document(PageSize.A4);
        
        try {
            
            // step 2:
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("c:/textfield.pdf"));
            
            // step 3: we open the document
            document.open();
            
            // step 4:
            BaseFont helv = BaseFont.createFont("Helvetica", "winansi", false);
            PdfContentByte cb = writer.getDirectContent();
            cb.moveTo(0, 0);
            String text = "João Paulo ruiz";
            String text2 = "João Paulo";
            float fontSize = 12;
            Color textColor = new GrayColor(0f);
            PdfFormField field = PdfFormField.createTextField(writer, false, false, 0);
            field.setWidget(new Rectangle(171, 750, 342, 769), PdfAnnotation.HIGHLIGHT_INVERT);
            field.setFlags(PdfAnnotation.FLAGS_PRINT);
            field.setFieldName("ATextField");
            field.setValueAsString(text);
            field.setDefaultValueAsString(text);
            field.setBorderStyle(new PdfBorderDictionary(2, PdfBorderDictionary.STYLE_SOLID));
            field.setPage();
            
            PdfFormField field2 = PdfFormField.createTextField(writer, false, false, 0);
            field2.setWidget(new Rectangle(200, 800, 400, 800), PdfAnnotation.HIGHLIGHT_INVERT);
            field2.setFlags(PdfAnnotation.FLAGS_PRINT);
            field2.setFieldName("ATextField2");
            field2.setValueAsString(text2);
            field2.setDefaultValueAsString(text2);
            field2.setBorderStyle(new PdfBorderDictionary(2, PdfBorderDictionary.STYLE_SOLID));
            field2.setPage();
            
            PdfAppearance tp = cb.createAppearance(171, 19);
            PdfAppearance da = (PdfAppearance)tp.getDuplicate();
            da.setFontAndSize(helv, fontSize);
            da.setColorFill(textColor);
            field.setDefaultAppearanceString(da);
            tp.beginVariableText();
            tp.saveState();
            tp.rectangle(2, 2, 167, 15);
            tp.clip();
            tp.newPath();
            tp.beginText();
            tp.setFontAndSize(helv, fontSize);
            tp.setColorFill(textColor);
            tp.setTextMatrix(4, 5);
            tp.showText(text);
            tp.endText();
            tp.restoreState();
            tp.endVariableText();
            
            PdfAppearance tp2 = cb.createAppearance(171, 19);
            PdfAppearance da2 = (PdfAppearance)tp2.getDuplicate();
            da2.setFontAndSize(helv, fontSize);
            da2.setColorFill(textColor);
            field2.setDefaultAppearanceString(da2);
            tp2.beginVariableText();
            tp2.saveState();
            tp2.rectangle(2, 2, 167, 15);
            tp2.clip();
            tp2.newPath();
            tp2.beginText();
            tp2.setFontAndSize(helv, fontSize);
            tp2.setColorFill(textColor);
            tp2.setTextMatrix(4, 5);
            tp2.showText(text2);
            tp2.endText();
            tp2.restoreState();
            tp2.endVariableText();
            
            field.setAppearance(PdfAnnotation.APPEARANCE_NORMAL, tp);
            field2.setAppearance(PdfAnnotation.APPEARANCE_NORMAL, tp2);
            writer.addAnnotation(field);
            writer.addAnnotation(field2);
            
        }
        catch(DocumentException de) {
            System.err.println(de.getMessage());
        }
        catch(IOException ioe) {
            System.err.println(ioe.getMessage());
        }
        
        // step 5: we close the document
        document.close();
    }
}