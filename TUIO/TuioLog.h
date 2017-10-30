/*
 TUIO C++ Library - part of the reacTIVision project
 http://reactivision.sourceforge.net/

 Copyright (c) 2017 Raphael Dumusc <raphael.dumusc@epfl.ch>

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef INCLUDED_TUIOLOG_H
#define INCLUDED_TUIOLOG_H

#include <string>
#include <functional>

namespace TUIO
{
    /** The level of the message. By default, level >= WARN go to std::cerr. */
    enum LogLevel
    {
        VERBOSE,
        DEBUG,
        INFO,
        WARN,
        ERROR,
        FATAL
    };

    /** Callback for handling log events in application code. */
    using LogHandler = std::function<void(LogLevel, const std::string&)>;

    /** Set a custom log handler. Default: print to std::cout/cerr. */
    void setLogHandler(LogHandler hanlder);

    /** @internal. Log a message. */
    void printLog(LogLevel level, const std::string& message);
}

#endif
