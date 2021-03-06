TARGET = harbour-gpsinfo

CONFIG += sailfishapp

SOURCES += \
    src/gpsdatasource.cpp \
    src/qmlsettingswrapper.cpp \
    src/gpsinfosettings.cpp \
    src/app.cpp \
    src/harbour-gpsinfo.cpp

OTHER_FILES += \
    qml/pages/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/InfoField.qml \
    qml/pages/SettingsPage.qml \
    qml/LocationFormatter.js \
    qml/providers/Providers.qml \
    qml/pages/ShowGridRowLabel.qml \
    qml/pages/AboutPage.qml \
    qml/pages/LicensePage.qml \
    qml/license.js \
    rpm/harbour-gpsinfo.spec \
    harbour-gpsinfo.desktop \
    qml/harbour-gpsinfo.qml \
    qml/pages/SatelliteInfoPage.qml \
    qml/CircleCalculator.js

HEADERS += \
    src/gpsdatasource.h \
    src/qmlsettingswrapper.h \
    src/gpsinfosettings.h \
    src/app.h

QT += positioning

LANGUAGES = de en fi nl ru sv

defineReplace(prependAll) {
 for(a, $$1): result += $$2$${a}$$3
 return($$result)
}

TRANSLATIONS = $$prependAll(LANGUAGES, $$PWD/i18n/, .ts)

TRANSLATIONS_FILES =

qtPrepareTool(LRELEASE, lrelease)
for(tsfile, TRANSLATIONS) {
 qmfile = $$shadowed($$tsfile)
 qmfile ~= s,.ts$,.qm,
 qmdir = $$OUT_PWD/locales
 qmfile = $$qmdir/$$basename(qmfile)
 !exists($$qmdir) {
  mkpath($$qmdir)|error("Aborting.")
 }
 command = $$LRELEASE -removeidentical $$tsfile -qm $$qmfile
 system($$command)|error("Failed to run: $$command")
 TRANSLATIONS_FILES += $$relative_path($$qmfile, $$OUT_PWD/)
}

locales.path = /usr/share/harbour-gpsinfo/locales

locales.files = $$TRANSLATIONS_FILES

images.files = \
    images/coverbg.png

images.path = /usr/share/harbour-gpsinfo/images

INSTALLS += locales images
