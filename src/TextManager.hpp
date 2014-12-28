/*
 * TextManager.hpp
 *
 *  Created on: Dec 28, 2014
 *      Author: Thurask
 */

#ifndef TEXTMANAGER_HPP_
#define TEXTMANAGER_HPP_

#include <QtCore>

class TextManager: public QObject
{
    Q_OBJECT

public:
    TextManager();
    virtual ~TextManager();

    Q_INVOKABLE
    QString readTextFile(QString uri);
};

#endif /* TEXTMANAGER_HPP_ */
