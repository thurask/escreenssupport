/*
 * TextManager.cpp
 *
 *  Created on: Dec 28, 2014
 *      Author: Thurask
 */

#include "TextManager.hpp"

TextManager::TextManager()
{
    // TODO Auto-generated constructor stub

}

QString TextManager::readTextFile(QString uri)
{
    QFile file(uri);
    file.open(QIODevice::ReadOnly);
    QTextStream textStream(&file);
    QString text;
    text = textStream.readAll();
    file.close();
    return text;
}

TextManager::~TextManager()
{
    // TODO Auto-generated destructor stub
}

